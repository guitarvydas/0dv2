Forin_Rewrite {
  program = item+
  item =
    | forin
    | any

  forin = sym<"for"> ws variable sym<"in"> ws expr "{" block "}"
  variable = id ws

  expr = anythingButLBrace
  block = anythingButRBrace

  anythingButLBrace = skipTo<"{">
  anythingButRBrace = skipTo<"}">

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')
}
