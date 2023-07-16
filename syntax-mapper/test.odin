m :: proc(n: string) -> ^Eh {
    /*⎨scoped _ eh⎬*/
    eh := new(Eh)
    eh.name = name
    eh.handler = container_handler
    return eh
}
