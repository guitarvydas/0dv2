QueueRewrite {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  push [kqueue ws1 kdot ws2 kpushback ws3 lp ws4 kamp ws5 operand1 kcomma ws6 operand2 rp] = ‛ «operand1».❲enqueue❳(«operand2») ’
  pop [kqueue ws1 kdot ws2 kpopfrontsafe ws3 lp ws4 kamp ws5 operand1 rp] = ‛ «operand1».❲dequeue❳() ’

  notlastoperand [anythingButComma lookahead] = ‛«anythingButComma»’
  lastoperand [anythingButRPar ws1] = ‛«anythingButRPar»«ws1»’

  anythingButComma [stuff ws] = ‛«stuff»’
  anythingButRPar [stuff ws] = ‛«stuff»’

  include(`tokens.fab.inc')
  include(`skim.fab.inc')
}

