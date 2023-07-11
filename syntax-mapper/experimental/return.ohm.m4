Return_Rewrite {
  program = item+
  item =
    | returnstatement
    | any

  returnstatement = sym<"return"> ws expr

  expr = anythingButEOL

  anythingButEOL = skipTo<srcnl,returnstatement>

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')
}
