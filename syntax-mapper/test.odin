step :: proc(sys: ^System($User_Datum)) -> (retry: bool) {
            msg, _ := fifo_pop(&component.output)
}
