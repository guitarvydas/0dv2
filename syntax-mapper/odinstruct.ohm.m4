Odin0Dstruct {
  program = item+
  item =
    | struct -- struct
    | anyToken -- other

  struct = id ws "::" ws "❲struct❳" ws structtype? "{" ws notLastField* lastField "}" ws

  structtype = "(" ws anythingButRPar ")" ws

  notLastField = id ws ":" ws anythingButComma "," ws ~"}"
  lastField =
    | &"}" -- done
    | id ws ":" ws anythingButComma "," ws &"}" -- fieldwithcomma
    | id ws ":" ws anythingButRBrace &"}" -- fieldnocomma

  anythingButComma = skim<",",struct> ws
  anythingButRBrace = skim<"}",struct> ws
  anythingButRPar = skim<")",struct> ws

  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')  
}
