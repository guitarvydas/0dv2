
OdinProcSignature {
  Program = Item+
  Item =
    | Proc -- proc
    | AnyToken -- other
    
  Proc = ProcSignature ProcDefinitionBody

  ProcDefinitionBody = "{" BodyStuff "}"

  ProcSignature =
    | ID "::" Pragma? "❲proc❳" OdinParameterList OdinReturnTypeList -- nonvoid
    | ID "::" Pragma? "❲proc❳" OdinParameterList &ProcDefinitionBody -- void

  OdinParameterList =
    | "(" ")" -- empty
    | "(" LastParameter ")" -- single
    | "(" NotLastParameter+ LastParameter ")" -- multiple

  OdinReturnType =
    | &ProcDefinitionBody -- void
    | "->" OdinReturnTypeList -- typed
  OdinReturnTypeList =
    |  "(" ")" -- empty
    |  "(" LastParameter ")" -- singlebracketed
    |  "(" NotLastReturnParameter+ LastReturnParameter ")" -- multiple
    | ~"(" SingleReturnParameter -- single

  NotLastParameter = AllocatorOrParameterName AnythingButComma ","
  LastParameter = AllocatorOrParameterName ~AnythingButComma AnythingButRPar

  NotLastReturnParameter = ParameterName? AnythingButComma ","
  LastReturnParameter = ParameterName? ~AnythingButComma AnythingButRPar
  SingleReturnParameter = ~ProcDefinitionBody AnythingButProcDefinitionBody

  Pragma = "#" "❲force_inline❳"

  ParameterName =
    | ID &"," -- sharedtype
    | ID ":" -- named
  Allocator =  "❲allocator❳" ":="
  AllocatorOrParameterName = Allocator | ParameterName

  BodyStuff = SkipTo<"}">
  AnythingButComma = SkipTo<",">
  AnythingButRPar = SkipTo<")">
  AnythingButProcDefinitionBody = SkipTo<ProcDefinitionBodyBeginning>
  ProcDefinitionBodyBeginning = "{"  

 
  include(`tokens.ohm.inc')
  space += uspc | unl | comment
  include(`skip.ohm.inc')  
}

