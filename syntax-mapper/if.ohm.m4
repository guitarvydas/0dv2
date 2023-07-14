Ifstatemet_Rewrite {
  program = item+
  item =
    | ifstatement
    | any

  ifstatement = sym<"if"> expr "{" then "}"

  expr = anythingButLBrace
  then = anythingButRBrace

  anythingButLBrace = skim<"{",ifstatement>
  anythingButRBrace = skim<"}",ifstatement>

  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')
}
