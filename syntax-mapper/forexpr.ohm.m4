Forexpr_Rewrite {
  program = item+
  item =
    | forexpr
    | any

  forexpr = sym<"for"> ws expr "{" block "}"

  expr = anythingButLBrace
  block = anythingButRBrace

  anythingButLBrace = skim<"{",forexpr>
  anythingButRBrace = skim<"}",forexpr>

  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')
}
