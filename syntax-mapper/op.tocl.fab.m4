Op_RewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’
  op [lhs op ws2 rhs terminator] = ‛(«op» «lhs» «rhs») terminator’

  operator_gt [c] = ‛>’
  operator_eol [c] = ‛«c»’

  lhs [idchain ws] = ‛«idchain»«ws»’
  rhs [anythingButEOL] = ‛«anythingButEOL»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')  
  include(`tocl.fab.inc')
}
