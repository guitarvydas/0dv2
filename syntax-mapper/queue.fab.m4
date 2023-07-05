QueueRewrite {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  push [kqueue ws1 kdot ws2 kpushback ws3 lp ws4 kamp ws5 operand1 operand2 rp] = ‛ «operand1».enqueue («operand2») ’
  pop [kqueue ws1 kdot ws2 kpopfrontsafe ws3 lp ws4 kamp ws5 operand1 rp] = ‛ «operand1».dequeue () ’

  notlastoperand [anythingButComma kcomma ws1] = ‛«anythingButComma»’
  lastoperand [anythingButRPar ws1] = ‛«anythingButRPar»’

  anythingButComma [stuff ws] = ‛«stuff»«ws»’
  anythingButRPar [stuff ws] = ‛«stuff»«ws»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
}

