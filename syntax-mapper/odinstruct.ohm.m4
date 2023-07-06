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

  anythingButComma = skipTo<",",struct> ws
  anythingButRBrace = skipTo<"}",struct> ws
  anythingButRPar = skipTo<")",struct> ws

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
}
