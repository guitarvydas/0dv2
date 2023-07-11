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
  therest = anythingButScopeOpen
  tID = ~"." id ~"." ws

  scopedvar = "‹scopedvar›"
  anythingButEOL = skipTo<eol,massignOrAssign>
  eol = "⦚"
  assignc = "=" | "⟪:=⟫"

  anythingButScopeOpen = skipTo<semanticscopebeginopen,massignOrAssign>

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
  include(`tocl.ohm.inc')
}

