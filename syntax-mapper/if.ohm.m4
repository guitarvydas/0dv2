Ifstatemet_Rewrite {
  program = item+
  item =
    | ifstatement
    | any

  ifstatement = sym<"if"> expr "{" then "}"

  expr = anythingButLBrace
  then = anythingButRBrace

  anythingButLBrace = skipTo<"{",ifstatement>
  anythingButRBrace = skipTo<"}",ifstatement>

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')
}
