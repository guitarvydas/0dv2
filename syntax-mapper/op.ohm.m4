Op_Rewrite {
  program = item+
  item =
    | op
    | any

  op = idchain ws operator ws expr eolc
  idchain =
    | idchain "." ws id -- rec
    | id -- bottom
  expr = anythingButEOL

  anythingButEOL = skipTo<eolc,op>
  operator = ">"
  eolc = srcnl | nl

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')
}
