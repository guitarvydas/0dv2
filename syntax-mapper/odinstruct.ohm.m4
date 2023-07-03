Odin0Dstruct {
  program = item+
  item =
    | struct -- struct
    | anyToken -- other

  struct = id "::" "❲struct❳" "{" notLastField* lastField "}"

  notLastField = id ":" anythingButComma ","
  lastField =
    | &"}" -- done
    | id ":" anythingButComma "," -- fieldwithcomma
    | id ":" anythingButRBrace -- fieldnocomma

  anythingButComma = skipTo<",">
  anythingButRBrace = skipTo<"}">

  include(`tokens.ohm.inc')
  space += uspc | unl | comment
  include(`skip.ohm.inc')  
}
