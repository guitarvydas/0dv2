Odin0Dstruct {
  Program = Item+
  Item =
    | Struct -- struct
    | AnyToken -- other

  Struct = ID "::" "❲struct❳" "{" NotLastField* LastField "}"

  NotLastField = ID ":" AnythingButComma ","
  LastField =
    | &"}" -- done
    | ID ":" AnythingButComma "," -- fieldwithcomma
    | ID ":" AnythingButRBrace -- fieldnocomma

  include(`tokens.ohm.inc')
  space += uspc | unl | comment
  include(`skip.ohm.inc')  
}
