
OdinProcSignature {
  program = item+
  item =
    | proc -- proc
    | anyToken -- other
    
  proc = procSignature procDefinitionBody

  procDefinitionBody = "{" bodyStuff "}"

  procSignature =
    | id "::" pragma? "❲proc❳" odinParameterList odinReturnTypeList -- nonvoid
    | id "::" pragma? "❲proc❳" odinParameterList &procDefinitionBody -- void

  pdinParameterList =
    | "(" ")" -- empty
    | "(" lastParameter ")" -- single
    | "(" notLastParameter+ LastParameter ")" -- multiple

  odinReturnType =
    | &procDefinitionBody -- void
    | "->" odinReturnTypeList -- typed
  odinReturnTypeList =
    |  "(" ")" -- empty
    |  "(" lastParameter ")" -- singlebracketed
    |  "(" notLastReturnParameter+ LastReturnParameter ")" -- multiple
    | ~"(" singleReturnParameter -- single

  notLastParameter = allocatorOrParameterName anythingButComma ","
  lastParameter = allocatorOrParameterName ~anythingButComma anythingButRPar

  notLastReturnParameter = parameterName? anythingButComma ","
  lastReturnParameter = parameterName? ~anythingButComma anythingButRPar
  singleReturnParameter = ~procDefinitionBody anythingButProcDefinitionBody

  pragma = "#" "❲force_inline❳"

  parameterName =
    | id &"," -- sharedtype
    | id ":" -- named
  allocator =  "❲allocator❳" ":="
  allocatorOrParameterName = allocator | parameterName

  bodyStuff = skipTo<"}">
  anythingButComma = skipTo<",">
  anythingButRPar = skipTo<")">
  anythingButProcDefinitionBody = skipTo<procDefinitionBodyBeginning>
  procDefinitionBodyBeginning = "{"  

 
  include(`tokens.ohm.inc')
  space += uspc | unl | comment
  include(`skip.ohm.inc')  
}

