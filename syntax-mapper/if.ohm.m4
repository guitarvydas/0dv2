IfRewrite {
  program = item+
  item =
    | ifstatement
    | any

  ifstatement = "❲if❳" expr "{" then "}"
  expr = anythingButRBrace
  then = anythingButRBrace

  anythingButRBrace = skipTo<"}">

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
}
