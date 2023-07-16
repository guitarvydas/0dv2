FuncallRewrite {
  program = item+
  item =
    | funcall -- funcall
    | any -- other

  funcall = 
    | ~dotc id ws lpar notLastArg* lastArg rpar -- single
    | idchain ws lpar notLastArg* lastArg rpar -- indirect

  notLastArg = anythingButComma ","
  lastArg = anythingButRPar

  anythingButComma = skim<",",funcall>
  anythingButRPar  = skim<rpar,funcall>

  rpar = ")"
  lpar = "("

  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')
  include(`tocl.ohm.inc')
}
