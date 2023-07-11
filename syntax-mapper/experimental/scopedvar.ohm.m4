ScopedvarRewrite {
  program = item+
  item =
    | massignOrAssign
    | any

  massignOrAssign = massign | assign
  assign = scopedvar ws lhs ws assignc ws rhs therest
  massign = scopedvar ws mlhs ws assignc ws rhs therest
  lhs = tID ~","
  mlhs = tID "," ws tID
  rhs = anythingButEOL
  therest = anythingButScopeEnd scopeend
  tID = ~"." id ~"." ws

  scopedvar = "‹scopedvar›"
  anythingButEOL = skipTo<eol,massignOrAssign>
  eol = "⦚"
  assignc = "=" | "⟪:=⟫"

  anythingButScopeEnd = skipTo<scopeend,massignOrAssign>

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
  include(`tocl.ohm.inc')
}

