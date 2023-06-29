Odin0Dproc {
  Program = Item+
  Item =
    | ProcDef -- procdef
    | Anytoken -- other

  ProcDef = ID "::" Inline? "❲proc❳" FormalsList ("->" RetList)? Whereclause? Procbody
  Inline = "#" "❲force_inline❳"
  Whereclause = "❲where❳" Wherebody
  FormalsList = "(" Formal* ")"
  Formal =
    | "❲allocator❳" ":=" "❲context❳" "." ID -- allocator
    | ID comma -- shorthand
    | ID ":" Type -- other
  Type = Typestuff+ 
  Typestuff =
    | "(" Typestuffinner+ ")" -- parenthesized
    | ~"(" ~")" Anytoken -- bottom

  Typestuffinner =
    | "(" Typestuffinner+ ")" -- parenthesized
    | ~"(" ~")" Anytoken  -- bottom

  RetList =
    | "(" Type* ")" -- multiple
    | Type -- single

  Procbody = "{" Bodystuff+ "}"
  Bodystuff =
    | string -- string
    | "{" Bodystuff+ "}" -- recursive
    | comment -- comment
    | ~"{" ~"}" Anytoken -- bottom
  Wherebody = Wbodystuff+
  Wbodystuff =
    | string -- string
    | comment -- comment
    | ~"{" ~"}" Anytoken -- bottom

  comma = ","
  
  include(`tokens.ohm.inc')
}

