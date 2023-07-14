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

  anythingButComma = skim<",",funcall>
  anythingButRPar  = skim<")",funcall>

  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')
  include(`tocl.ohm.inc')
}
