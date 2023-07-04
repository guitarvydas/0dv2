AppendRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  Funcall_quoted [id Args] = ‛(«id» «Args»)’
  Funcall_evaled [Operand Args] = ‛(funcall «Operand» «Args»)’

  Args [lp Arg* rp] = ‛«Arg»’

  Arg_arg [Operand comma?] = ‛«Operand» ’
  Arg_messageliteral [lp kml Stuff rp comma?] = ‛ (Message_Literal «Stuff») ’
  
  Funcid [id] = ‛«id»’
  
  Operand_recursive [Operand kdot id] = ‛«Operand»«kdot»«id»’
  Operand_bottom [id] = ‛«id»’

  id [idfirst idrest*] = ‛«idfirst»«idrest»’
  idfirst [c] = ‛«c»’
  idrest  [c] = ‛«c»’
  dq [c] = ‛"’
  string [dq1 cs* dq2] = ‛"«cs»"’
}
