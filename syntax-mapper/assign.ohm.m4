AssignRewrite {
  program = item+
  item =
    | massignOrAssign
    | any

  massignOrAssign = massign | assign
  assign = lhs ws assignc ws rhs
  massign = mlhs ws assignc ws rhs
  lhs = idchain ws ~","
  mlhs = idchain ws "," ws id ws
  rhs = anythingButEOL

  anythingButEOL = skipTo<eol,massignOrAssign>
  eol = srcnl | nl | end
  assignc = "=" | "⟪:=⟫"

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
  include(`tocl.ohm.inc')
}
