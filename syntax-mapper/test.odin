Eh :: struct {
    name:         string,
    input:        FIFO,
    output:       FIFO,
    yield:        FIFO,
    children:     []^Eh,
    connections:  []Connector,
    handler:      #type proc(eh: ^Eh, message: Message),
    leaf_handler: rawptr, //#type proc(eh: ^Eh, message: Message($Datum)),
    leaf_data:    rawptr, //#type proc(eh: ^Eh, message: Message($Datum), data: ^$Data),
    state:        int,
}
