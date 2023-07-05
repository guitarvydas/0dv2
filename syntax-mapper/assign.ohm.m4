AssignRewrite {
  program = item+
  item =
    | massign
    | assign
    | any

  assign = lhs "=" ws rhs
  massign = mlhs "=" ws rhs
  lhs = id ws ~","
  mlhs = id ws "," ws id ws
  rhs = anythingButEOL

  anythingButEOL = skipTo<eol>
  eol = "⦚"

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
}
