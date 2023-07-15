AppendRewrite {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’
  append [kappend lp ws1 kamp ws2 Operand1 kcomma ws3 Operand2 rp] = ‛\n«Operand1».❲append❳ ❪«ws1»«ws2»«ws3»«Operand2»❫’
  operand_recursive [Operand kdot id ws] = ‛«Operand»«kdot»«id»«ws»’
  operand_bottom [id ws] = ‛«id»«ws»’

  include(`tokens.fab.inc')
}
