
route :: proc(sys: ^System($User_Datum), from: ^Component(User_Datum), msg: Message(User_Datum)) {
    for c in sys.connectors {
        if c.src == from && c.src_port == msg.port {
            new_msg := msg
            new_msg.port = c.dst_port
            fifo_push(&c.dst.input, new_msg)
        }
    }
}
