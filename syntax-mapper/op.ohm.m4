Op_Rewrite {
  program = item+
  item =
    | op
    | any

  op = lhs operator ws rhs terminator
  lhs = idchain ws
  rhs = anythingButEOL

  anythingButEOL = skipTo<op,terminator>
  terminator = operator
  operator =
    | ">" -- gt
    | eolc -- eol

  eolc = srcnl | nl

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')
  include(`tocl.ohm.inc')
}
