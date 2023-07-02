package zd

import "core:container/queue"
import "core:fmt"
import "core:mem"
import "core:strings"
import "core:intrinsics"
import "core:log"
import dt "../../datum"

Eh :: struct {
    name:         string,
    input:        FIFO,
    output:       FIFO,
    yield:        FIFO,
    data:	  ^any,   
    children:     []^Eh, 
    connections:  []Connector,  
    handler:      #type proc(eh: ^Eh, message: Message, data: ^any),
    state:        int,
}






Message :: struct {
    port:  string,
    datum: dt.Datum,
}



make_container :: proc(name: string) -> ^Eh {
    eh := new(Eh)
    eh.name = name
    eh.handler = container_handler
    
    return eh
}
