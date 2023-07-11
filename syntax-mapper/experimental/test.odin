c :: proc(m: Message) -> any {
  /*/*beginsemanticscope*/ c proc ⎬*/
    /*/*scopedvar*/ c y */
    y := h(i)
  /*/*endsemanticscope*/ c ⎬*/
}

// alternate syntax? avoids being deleted by comment-remover
  /*⎨⎧ c proc ⎬*/
    /*⎨+ c y ⎬*/
    y := h(i)
  /*⎨⎭ c ⎬*/

//  ⎨⎧ c proc ⎬
//    ⎨+ c y ⎬
//    y := h(i)
//  ⎨⎭ c ⎬
