Op_RewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’
  op [lhs op ws2 rhs terminator] = ‛(«op»«ws2» «lhs» «rhs») «terminator»’

  operator_gt [c] = ‛>’
  operator_and [c] = ‛and’
  operator_eq [c] = ‛eq’

  lhs [idchain ws] = ‛«idchain»«ws»’
  rhs [anythingButEOL] = ‛«anythingButEOL»’

  include(`tokens.fab.inc')
  include(`skim.fab.inc')  
  include(`tocl.fab.inc')
}
