AssignRewrite {
  program = item+
  item =
    | massign
    | assign
    | any

  assign = lhs assignc ws rhs
  massign = mlhs assignc ws rhs
  lhs = id ws ~","
  mlhs = id ws "," ws id ws
  rhs = anythingButEOL

  anythingButEOL = skipTo<eol>
  eol = "⦚"
  assignc = "=" | ":="

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
}
