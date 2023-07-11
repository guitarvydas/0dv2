FuncallRewrite {
  program = item+
  item =
    | funcall -- funcall
    | any -- other

  funcall = 
    | ~dotc id ws "(" notLastArg* lastArg ")" -- single
    | idchain ws "(" notLastArg* lastArg ")" -- indirect

  notLastArg = anythingButComma ","
  lastArg = anythingButRPar

  anythingButComma = skipTo<",",funcall>
  anythingButRPar  = skipTo<")",funcall>

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')
  include(`tocl.ohm.inc')
}
