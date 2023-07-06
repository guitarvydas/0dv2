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

  anythingButComma = skipTo<",",funcall>
  anythingButRPar = skipTo<")",funcall>

  skipTo<stopBefore,macro> =
    | &stopBefore -- done
    | macro -- macro
    | inner skipTo<stopBefore,macro> -- continue
  inner =
    | "(" ws inner* ")" -- nestedparens
    | "{" ws inner* "}" -- nestedbraces
    | ~"(" ~")" ~"{" ~"}" anyToken -- bottom

  include(`tokens.ohm.inc')
}
