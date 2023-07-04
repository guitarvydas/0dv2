FuncallRewrite {
  program = item+
  item =
    | funcall -- funcall
    | any -- other

  funcall = id ws "(" anythingButRPar ")"

  anythingButRPar = skipTo<")">

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
}
