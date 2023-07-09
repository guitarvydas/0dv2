// Clones the datum portion of the message.
clone_datum :: proc(message: Message) -> any {
    /*tempvar*/ datum_ti := type_info_of(message.datum.id)

    /*tempvar*/ new_datum_ptr := mem.alloc(datum_ti.size, datum_ti.align) or_else panic("data_ptr alloc")
    mem.copy_non_overlapping(new_datum_ptr, message.datum.data, datum_ti.size)

    return any{new_datum_ptr, message.datum.id},
}
