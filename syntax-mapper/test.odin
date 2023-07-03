Eh :: struct {
    name:         string,
    input:        FIFO,
    output:       FIFO,
    yield:        FIFO,
    data:	  ^any,   // this should be a Union: a Leaf has (instance) data, while a Container  
    children:     []^Eh, // has instance data, too, but the shape is predefined to be "children" and
    connections:  []Connector,  // "connections"
    handler:      #type proc(eh: ^Eh, message: Message, data: ^any),
    state:        int,
}

make_container :: proc(name: string) -> ^Eh {
    eh := new(Eh)
    eh.name = name
    eh.handler = container_handler
    // eh.data, in this case, is "children" and "connections"
    return eh
}
output_list :: proc(eh: ^Eh, allocator := context.allocator) -> []Message {
    list := make([]Message, eh.output.len)

    iter := make_fifo_iterator(&eh.output)
    for msg, i in fifo_iterate(&iter) {
        list[i] = msg
    }

    return list
}

set_state :: #force_inline proc(eh: ^Eh, state: $State)
where
    intrinsics.type_is_enum(State)
{
    eh.state = int(state)
}
