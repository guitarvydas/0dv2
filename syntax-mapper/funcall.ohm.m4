FuncallRewrite {
  program = item+
  item =
    | funcall -- funcall
    | any -- other

  funcall = 
    | ~dotc id ws "(" notLastArg* lastArg ")" -- single
    | idchain ws "(" notLastArg* lastArg ")" -- indirect

  idchain =
    | idchain dotc id -- rec
    | id -- bottom

  dotc = "." ws
  notLastArg = anythingButComma ","
  lastArg = anythingButRPar
  

  anythingButComma = skipTo<",">
  anythingButRPar = skipTo<")">

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
}
