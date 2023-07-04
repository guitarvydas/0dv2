AppendRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  assign [Operand1 keq ws Operand2] = ‛\n(setf «Operand1» «Operand2»)\n’

  operand_recursive [Operand kdot id ws] = ‛«Operand»«kdot»«id»’
  operand_bottom [id ws] = ‛«id»’

  include(`tokens.fab.inc')
}
