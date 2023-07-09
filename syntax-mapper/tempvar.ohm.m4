TempvarRewrite {
  program = item+
  item =
    | massignOrAssign
    | any

  massignOrAssign = massign | assign
  assign = tempvar ws lhs ws assignc ws rhs
  massign = tempvar ws mlhs ws assignc ws rhs
  lhs = tID ~","
  mlhs = tID "," ws tID
  rhs = anythingButEOL
  tID = ~"." id ~"." ws

  tempvar = "‹tempvar›"
  anythingButEOL = skipTo<eol,massignOrAssign>
  eol = "⦚"
  assignc = "=" | "⟪:=⟫"

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
  include(`tocl.ohm.inc')
}

