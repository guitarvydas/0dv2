Message_Literal_RewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’
  message_Literal [kmessage lp ws1 id ws2 rp ws3 lb ws4 Operand1 kcomma ws5 Operand2 rb ws6] = ‛ Message_Literal («Operand1», «Operand2»)’
  operand_recursive [Operand kdot id ws] = ‛«Operand»«kdot»«id»«ws»’
  operand_bottom [id ws] = ‛«id»«ws»’

  include(`tokens.fab.inc')
}
