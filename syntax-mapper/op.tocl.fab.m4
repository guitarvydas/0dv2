Op_RewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’
  op [lhs op ws2 rhs eolc] = ‛(«op» «lhs» «rhs»)«eolc»’

  operator_gt [c] = ‛>’
  

  include(`tokens.fab.inc')
  include(`skip.fab.inc')  
  include(`tocl.fab.inc')
}
