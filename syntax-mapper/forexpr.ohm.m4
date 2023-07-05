Forexpr_Rewrite {
  program = item+
  item =
    | forexpr
    | any

  forexpr = sym<"for"> ws expr "{" block "}"

  expr = anythingButLBrace
  block = anythingButRBrace

  anythingButLBrace = skipTo<"{">
  anythingButRBrace = skipTo<"}">

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')
}
