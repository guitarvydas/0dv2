package zd

import "core:container/queue"
import "core:fmt"
import "core:mem"
import "core:strings"
import "core:intrinsics"
import "core:log"
import dt "../../datum"





















Eh :: struct {
    name:         string,
    input:        FIFO,
    output:       FIFO,
    yield:        FIFO,
    data:	  ^any,   
    children:     []^Eh, 
    connections:  []Connector,  
    handler:      #type proc(eh: ^Eh, message: Message, data: ^any),
    state:        int,
}






Message :: struct {
    port:  string,
    datum: dt.Datum,
}



make_container :: proc(name: string) -> ^Eh {
    eh := new(Eh)
    eh.name = name
    eh.handler = container_handler
    
    return eh
}

leaf_new :: proc(name: string, handler: proc(^Eh, Message, ^any), data: ^any) -> ^Eh {
    eh := new(Eh)
    eh.name = name
    eh.handler = handler
    eh.data = data
    return eh
}



make_message :: proc(port_as_string: string, data: dt.Datum) -> Message {
    return {
        
	
	

        
	
	
        port  = port_clone (port_as_string),
        datum = dt.clone_datum (data) 
    }
}
make_message_from_string :: proc(port: string, s: string) -> Message {
    d := dt.create_datum (raw_data (s), len (s), dt.datum_to_string, "StringMessage")
    cloned_port := port_clone (port) 
    return make_message (cloned_port, d)
}


message_clone :: proc(message: Message) -> Message {
    new_message := Message {
        port = port_clone (message.port), 
        datum = dt.clone_datum (message.datum)
    }
    return new_message
}

port_clone :: proc (port : string) -> string {
    return strings.clone (port)
}


discard_message_innards :: proc(msg: Message) {
    delete_string (msg.port)
    dt.reclaim_datum (msg.datum)
    
}



send :: proc(eh: ^Eh, port: string, datum: dt.Datum) {
    msg := make_message (port, datum)
    fifo_push(&eh.output, msg)
}








yield :: proc(eh: ^Eh, port: string, data: $Data) {
    msg := make_message(port, data)
    fifo_push(&eh.yield, msg)
}



output_list :: proc(eh: ^Eh, allocator := context.allocator) -> []Message {
    list := make([]Message, eh.output.len)

    iter := make_fifo_iterator(&eh.output)
    for msg, i in fifo_iterate(&iter) {
        list[i] = msg
    }

    return list
}


container_handler :: proc(eh: ^Eh, message: Message, instance_data: ^any) {
    
    log.debug ("container handler routing")
    route(eh, nil, message)
    log.debug ("container handler stepping")
    for any_child_ready(eh) {
        step_children(eh)
    }
}



set_state :: #force_inline proc(eh: ^Eh, state: $State)
where
    intrinsics.type_is_enum(State)
{
    eh.state = int(state)
}


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
