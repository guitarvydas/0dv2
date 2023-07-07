Op_Rewrite {
  program = item+
  item =
    | op
    | any

  op = lhs operator ws rhs eolc
  lhs = idchain ws
  rhs = anythingButEOL

  anythingButEOL = skipTo<eolc,op>
  operator =
    | ">" -- gt
    
  eolc = srcnl | nl

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')
  include(`tocl.ohm.inc')
}
