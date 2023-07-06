Forexpr_Rewrite {
  program = item+
  item =
    | forexpr
    | any

  forexpr = sym<"for"> ws expr "{" block "}"

  expr = anythingButLBrace
  block = anythingButRBrace

  anythingButLBrace = skipTo<"{",forexpr>
  anythingButRBrace = skipTo<"}",forexpr>

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')
}
