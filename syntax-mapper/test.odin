// s :: proc(e: ^Eh, p: string, d: $Data) {
// E
// }
send :: proc(eh: ^Eh, port: string, data: $Data) {
    when Data == any {
        msg := Message {
            port  = port,
            datum = clone_datum(data),
        }
    } else {
        msg := make_message(port, data)
    }
    fifo_push(&eh.output, msg)
}

