Message :: struct($User_Datum: typeid) {
    port:  Port,
    datum: User_Datum,
}

send :: proc(component: ^Component($User_Datum), port: Port, data: User_Datum) {
    fifo_push(&component.output, Message(User_Datum){port, data})
}
