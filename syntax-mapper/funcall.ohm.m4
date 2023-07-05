FuncallRewrite {
  program = item+
  item =
    | funcall -- funcall
    | any -- other

  funcall = id ws "(" notLastArg* lastArg ")"

  notLastArg = anythingButComma ","
  lastArg = anythingButRPar
  

  anythingButComma = skipTo<",">
  anythingButRPar = skipTo<")">

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
}
