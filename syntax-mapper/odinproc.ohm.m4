
Odin0Dproc {
  Program = Item+
  Item =
    | ProcDef -- procdef
    | Anytoken -- other

  ProcDef = ProcSignature Procbody
  ProcSignature = ID "::" Inline? "❲proc❳" FormalsList RetList? Whereclause?

  Inline = "#" "❲force_inline❳"
  Whereclause = "❲where❳" Wherebody
  FormalsList = "(" Formal* ")"
  Formal =
    | "❲allocator❳" ":=" "❲context❳" "." SkipToRPar -- allocatorrpar
    | "❲allocator❳" ":=" "❲context❳" "." SkipToComma comma -- allocatorcomma
    | ID comma -- shorthand
    | ID ":" TypeSkipToComma comma -- othercomma
    | ID ":" TypeSkipToRPar ")" -- otherrpar

  TypeSkipToRPar = SkipToRPar
  TypeSkipToComma = SkipToComma
  
  SkipToComma =
    | "(" SkipToRPar ")" -- parenthesized
    | ~"," Anytoken &comma -- comma
    | ~"," Anytoken SkipToComma -- continue

  SkipToRPar =
    | "(" SkipToRPar ")" -- parenthesized
    | ~")" Anytoken &")" -- rpar
    | ~")" Anytoken SkipToRPar -- continue

  RetList = "->" RetType
  RetType = SkipToWhereOrLBrace
  SkipToWhereOrLBrace =
    | ~"❲where❳" ~"{" Anytoken &"❲where❳" -- where
    | ~"❲where❳" ~"{" Anytoken &"{" -- lbrace
    | ~"❲where❳" ~"{" Anytoken SkipToWhereOrLBrace -- continue

  SkipToLBrace =
    | ~"{" Anytoken &"{" -- lbrace
    | ~"{" Anytoken SkipToLBrace -- continue

  Procbody = "{" Line* "}"
  Line = (~in_nl any) in_nl
    
  Wherebody = SkipToLBrace

  comma = ","
  
  include(`tokens.ohm.inc')
  space += uspc | unl | comment
}

