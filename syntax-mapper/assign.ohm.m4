AssignRewrite {
  program = item+
  item =
    | massignOrAssign
    | any

  massignOrAssign = massign | assign
  assign = lhs ws assignc ws rhs
  massign = mlhs ws assignc ws rhs
  lhs = id ws ~","
  mlhs = id ws "," ws id ws
  rhs = anythingButEOL

  anythingButEOL = skipTo<eol,massignOrAssign>
  eol = "⦚"
  assignc = "=" | ":="

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
}
