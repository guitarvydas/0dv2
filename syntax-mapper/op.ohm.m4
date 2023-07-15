Op_Rewrite {
  program = item+
  item =
    | op
    | any

  op = lhs operator ws rhs terminator
  lhs = idchain ws
  rhs = anythingButEOL

  anythingButEOL = skim<terminator, op>
  terminator = operator | &eolc | &end
  operator =
    | ">" -- gt
    | "⟪==⟫" -- eq
    | "⟪&&⟫" -- and

  eolc = srcnl | nl

  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')
  include(`tocl.ohm.inc')
}
