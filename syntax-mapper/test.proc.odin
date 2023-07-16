make_container :: proc(name: string) -> ^Eh {
}

make_leaf_simple :: proc(name: string, handler: proc(^Eh, Message)) -> ^Eh {
}

make_leaf_with_data :: proc(name: string, data: ^$Data, handler: proc(^Eh, Message, ^Data)) -> ^Eh {
    leaf_handler_with_data :: proc(eh: ^Eh, message: Message) {
    }
}

make_message :: proc(port: string, data: $Data) -> Message {
}

message_clone :: proc(message: Message) -> Message {
}

clone_datum :: proc(message: Message) -> any {
}

destroy_message :: proc(msg: Message) {
}

send :: proc(eh: ^Eh, port: string, data: $Data) {
}

yield :: proc(eh: ^Eh, port: string, data: $Data) {
}

output_list :: proc(eh: ^Eh, allocator := context.allocator) -> []Message {
}

container_handler :: proc(eh: ^Eh, message: Message) {
}

set_state :: #force_inline proc(eh: ^Eh, state: $State)
where
    intrinsics.type_is_enum(State)
{
}

destroy_container :: proc(eh: ^Eh) {
    drain_fifo :: proc(fifo: ^FIFO) {
    }
}
fifo_is_empty :: proc(fifo: FIFO) -> bool {
}

make_fifo_iterator :: proc(q: ^FIFO) -> FIFO_Iterator {
}

fifo_iterate :: proc(iter: ^FIFO_Iterator) -> (item: Message, idx: int, ok: bool) {
}
sender_eq :: proc(s1, s2: Sender) -> bool {
}

deposit :: proc(c: Connector, message: Message) {
}

step_children :: proc(container: ^Eh) {
}

route :: proc(container: ^Eh, from: ^Eh, message: Message) {
}

any_child_ready :: proc(container: ^Eh) -> (ready: bool) {
}

child_is_ready :: proc(eh: ^Eh) -> bool {
}

print_output_list :: proc(eh: ^Eh) {
}
