make_container :: proc(name: string) -> ^Eh {}
leaf_new :: proc(name: string, handler: proc(^Eh, Message, ^any), data: ^any) -> ^Eh {}
make_message :: proc(port_as_string: string, data: dt.Datum) -> Message {}
make_message_from_string :: proc(port: string, s: string) -> Message {}
message_clone :: proc(message: Message) -> Message {}
port_clone :: proc (port : string) -> string {}
discard_message_innards :: proc(msg: Message) {}
send :: proc(eh: ^Eh, port: string, datum: dt.Datum) {}
yield :: proc(eh: ^Eh, port: string, data: $Data) {}
output_list :: proc(eh: ^Eh, allocator := context.allocator) -> []Message {}
container_handler :: proc(eh: ^Eh, message: Message, instance_data: ^any) {}
set_state :: #force_inline proc(eh: ^Eh, state: $State)
destroy_container :: proc(eh: ^Eh) {}
drain_fifo :: proc(fifo: ^FIFO) {}
fifo_is_empty :: proc(fifo: FIFO) -> bool {}
make_fifo_iterator :: proc(q: ^FIFO) -> FIFO_Iterator {}
fifo_iterate :: proc(iter: ^FIFO_Iterator) -> (item: Message, idx: int, ok: bool) {}
sender_eq :: proc(s1, s2: Sender) -> bool {}
deposit :: proc(c: Connector, message: Message) {}
step_children :: proc(container: ^Eh) {}
route :: proc(container: ^Eh, from: ^Eh, message: Message) {}
any_child_ready :: proc(container: ^Eh) -> (ready: bool) {}
child_is_ready :: proc(eh: ^Eh) -> bool {}
print_output_list :: proc(eh: ^Eh) {}
