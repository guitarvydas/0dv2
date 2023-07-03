Odin0Dstruct {
  program = item+
  item =
    | struct -- struct
    | anyToken -- other

  struct = id "::" ws "❲struct❳" ws "{" ws notLastField* lastField "}" ws

  notLastField = id ":" ws anythingButComma "," ws
  lastField =
    | &"}" -- done
    | id ":" ws anythingButComma "," ws -- fieldwithcomma
    | id ":" ws anythingButRBrace -- fieldnocomma

  anythingButComma = skipTo<","> ws
  anythingButRBrace = skipTo<"}"> ws

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
}
