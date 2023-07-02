make_container :: proc(name: string) -> ^Eh {
    eh := new(Eh)
    eh.name = name
    eh.handler = container_handler
    // eh.data, in this case, is "children" and "connections"
    return eh
}
