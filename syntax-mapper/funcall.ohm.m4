FuncallRewrite {
  program = item+
  item =
    | funcall -- funcall
    | any -- other

  funcall = idchain ws "(" notLastArg* lastArg ")"

  idchain =
    | idchain "." ws id -- rec
    | id -- bottom

  notLastArg = anythingButComma ","
  lastArg = anythingButRPar
  

  anythingButComma = skipTo<",">
  anythingButRPar = skipTo<")">

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
}
