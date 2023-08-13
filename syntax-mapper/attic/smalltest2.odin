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
