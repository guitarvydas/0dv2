Ifstatemet_Rewrite {
  program = item+
  item =
    | ifstatement
    | any

  ifstatement = sym<"if"> expr "{" then "}"

  expr = anythingButLBrace
  then = anythingButRBrace

  anythingButLBrace = skipTo<"{">
  anythingButRBrace = skipTo<"}">

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')
}
