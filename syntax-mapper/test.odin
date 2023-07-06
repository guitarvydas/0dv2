
add_connection :: proc(sys: ^System($User_Datum), connection: Connector(User_Datum)) {
    append(&sys.connectors, connection)
}
