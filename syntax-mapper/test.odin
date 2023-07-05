step :: proc(sys: ^System($User_Datum)) -> (retry: bool) {
    for component in sys.components {
        for component.output.len > 0 {
            msg, _ := fifo_pop(&component.output)
            route(sys, component, msg)
        }
    }

    for component in sys.components {
        msg, ok := fifo_pop(&component.input)
        if ok {
            component.state(component, msg.port, msg.datum)
            retry = true
        }
    }
    return retry
}
