step :: proc(sys: ^System($User_Datum)) -> (retry: bool) {
    retry = true
    retry, ok = true
    retry, _ = true
    retry := true
    retry, ok := true
    retry, _ := true
}
