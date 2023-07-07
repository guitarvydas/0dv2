
route :: proc(sys: ^System($User_Datum), from: ^Component(User_Datum), msg: Message(User_Datum)) {
    c.src == from
}
