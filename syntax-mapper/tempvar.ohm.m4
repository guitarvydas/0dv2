TempvarRewrite {
  program = item+
  item =
    | massignOrAssign
    | any

  massignOrAssign = massign | assign
  assign = tempvar ws lhs ws assignc ws rhs therest
  massign = tempvar ws mlhs ws assignc ws rhs therest
  lhs = tID ~","
  mlhs = tID "," ws tID
  rhs = anythingButEOL
  therest = anythingButEND
  tID = ~"." id ~"." ws

  tempvar = "‹tempvar›"
  anythingButEOL = skipTo<eol,massignOrAssign>
  eol = "⦚"
  assignc = "=" | "⟪:=⟫"

  anythingButEND = skipTo<scopeend,massignOrAssign>

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
  include(`tocl.ohm.inc')
}

