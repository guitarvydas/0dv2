tran :: proc(component: ^Component($User_Datum), state: proc(^Component(User_Datum), Port, User_Datum)) {
    component.state(component, EXIT, nil)
    component.state = state
    component.state(component, ENTER, nil)
    a(b).c.d(e,f) // should become -> (a b).c.(d e f) -> (funcall (c (a b)) e f)
}
