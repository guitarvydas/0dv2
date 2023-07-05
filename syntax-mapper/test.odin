add_connection :: proc(sys: ^System($User_Datum), connection: Connector(User_Datum)) {
    append(&sys.connectors, connection)
}

send :: proc(component: ^Component($User_Datum), port: Port, data: User_Datum) {
    fifo_push(&component.output, Message(User_Datum){port, data})
}
