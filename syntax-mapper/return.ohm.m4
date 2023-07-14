Return_Rewrite {
  program = item+
  item =
    | returnstatement
    | any

  returnstatement = sym<"return"> ws expr

  expr = anythingButEOL

  anythingButEOL = skim<srcnl,returnstatement>

  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')
}
