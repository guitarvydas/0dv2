AppendRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  Assign [Operand1 keq Operand2] = ‛\n(setf «Operand1» «Operand2») ’

  Operand_recursive [Operand kdot id] = ‛«Operand»«kdot»«id»’
  Operand_bottom [id] = ‛«id»’

  id [idfirst idrest*] = ‛«idfirst»«idrest»’
  idfirst [c] = ‛«c»’
  idrest  [c] = ‛«c»’
  dq [c] = ‛"’
  string [dq1 cs* dq2] = ‛"«cs»"’
}
