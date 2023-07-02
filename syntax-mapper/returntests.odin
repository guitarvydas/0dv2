    -> () {}
    -> bool {}
    -> {}
-> ^Eh {
-> ^Eh {
-> Message {
-> Message {
-> Message {
-> string {
discard_message_innards :: proc(msg: Message) {
send :: proc(eh: ^Eh, port: string, datum: dt.Datum) {
yield :: proc(eh: ^Eh, port: string, data: $Data) {
-> []Message {
container_handler :: proc(eh: ^Eh, message: Message, instance_data: ^any) {
set_state :: #force_inline proc(eh: ^Eh, state: $State)
destroy_container :: proc(eh: ^Eh) {
drain_fifo :: proc(fifo: ^FIFO) {
-> bool {
-> FIFO_Iterator {
-> (item: Message, idx: int, ok: bool) {
-> bool {
deposit :: proc(c: Connector, message: Message) {
step_children :: proc(container: ^Eh) {
route :: proc(container: ^Eh, from: ^Eh, message: Message) {
-> (ready: bool) {
-> bool {
print_output_list :: proc(eh: ^Eh) {
