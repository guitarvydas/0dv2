AssignRewrite {
  program = item+
  item =
    | assign -- assign
    | any -- other

  assign = lhs "=" ws rhs
  lhs = id ws
  rhs = anythingButEOL

  anythingButEOL = skipTo<eol>
  eol = "⦚"

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
}
