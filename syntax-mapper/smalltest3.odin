destroy_container :: proc(eh: ^Eh) {
    drain_fifo :: proc(fifo: ^FIFO) {
        for fifo.len > 0 {
            msg, _ := fifo_pop(fifo)
            discard_message_innards (msg)
        }
    }
    drain_fifo(&eh.input)
    drain_fifo(&eh.output)
    free(eh)
}


FIFO       :: queue.Queue(Message)
fifo_push  :: queue.push_back
fifo_pop   :: queue.pop_front_safe

fifo_is_empty :: proc(fifo: FIFO) -> bool {
    return fifo.len == 0
}

FIFO_Iterator :: struct {
    q:   ^FIFO,
    idx: int,
}

make_fifo_iterator :: proc(q: ^FIFO) -> FIFO_Iterator {
    return {q, 0}
}

fifo_iterate :: proc(iter: ^FIFO_Iterator) -> (item: Message, idx: int, ok: bool) {
    if iter.q.len == 0 {
        ok = false
        return
    }

    i := (uint(iter.idx)+iter.q.offset) % len(iter.q.data)
    if i < iter.q.len {
        ok = true
        idx = iter.idx
        iter.idx += 1
        #no_bounds_check item = iter.q.data[i]
    }
    return
}




Connector :: struct {
    direction: Direction,
    sender:    Sender,
    receiver:  Receiver,
}

Direction :: enum {
    Down,
    Across,
    Up,
    Through,
}



Sender :: struct {
    component: ^Eh,
    port:      string,
}



Receiver :: struct {
    queue: ^FIFO,
    port:  string,
}


sender_eq :: proc(s1, s2: Sender) -> bool {
    return s1.component == s2.component && s1.port == s2.port
}


deposit :: proc(c: Connector, message: Message) {
    new_message := message_clone(message)
    new_message.port = port_clone (c.receiver.port)
    log.debugf("DEPOSIT", message.port)
    fifo_push(c.receiver.queue, new_message)
}

step_children :: proc(container: ^Eh) {
    for child in container.children {
        msg: Message
        ok: bool

        switch {
        case child.yield.len > 0:
            msg, ok = fifo_pop(&child.yield)
        case child.input.len > 0:
            msg, ok = fifo_pop(&child.input)
        }

        if ok {
            log.debugf("INPUT  0x%p %s/%s(%s)", child, container.name, child.name, msg.port)
            child.handler(child, msg, child.data)
            log.debugf("child handler stepped  0x%p %s/%s(%s)", child, container.name, child.name, msg.port)
            discard_message_innards (msg)
        }

        for child.output.len > 0 {
            msg, _ = fifo_pop(&child.output)
            log.debugf("OUTPUT 0x%p %s/%s(%s)", child, container.name, child.name, msg.port)
            route(container, child, msg)
            discard_message_innards (msg)
        }
    }
}



route :: proc(container: ^Eh, from: ^Eh, message: Message) {
            log.debugf("ROUTE", container.name, from.name, message.port)
    from_sender := Sender{from, message.port}
    no_deposits := true

    for connector in container.connections {
        if sender_eq(from_sender, connector.sender) {
            deposit(connector, message)
	    no_deposits = false
        }
    }
    if no_deposits {
      log.error ("### message ignored ###")
      log.error ("###", container.name, from.name, message.port, message.datum.repr (message.datum))
      assert (false)
    }
}

any_child_ready :: proc(container: ^Eh) -> (ready: bool) {
    for child in container.children {
        if child_is_ready(child) {
            return true
        }
    }
    return false
}

child_is_ready :: proc(eh: ^Eh) -> bool {
    return !fifo_is_empty(eh.output) || !fifo_is_empty(eh.input) || !fifo_is_empty(eh.yield)
}


print_output_list :: proc(eh: ^Eh) {
    write_rune   :: strings.write_rune
    write_string :: strings.write_string

    sb: strings.Builder
    defer strings.builder_destroy(&sb)

    write_rune(&sb, '[')

    iter := make_fifo_iterator(&eh.output)
    for msg, idx in fifo_iterate(&iter) {
        if idx > 0 {
            write_string(&sb, ", ")
        }
        fmt.sbprintf(&sb, "{{%s, %v}", msg.port, msg.datum.repr (msg.datum))
    }
    strings.write_rune(&sb, ']')

    fmt.println(strings.to_string(sb))
}
