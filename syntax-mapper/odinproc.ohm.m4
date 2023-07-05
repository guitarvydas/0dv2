
OdinProcSignature {
  program = item+
  item =
    | proc -- proc
    | anyToken -- other
    
  proc = procSignature procDefinitionBody

  procDefinitionBody = "{" ws bodyStuff "}" ws

  procSignature =
    | id ws "::" ws pragma? "❲proc❳" ws odinParameterList odinReturnTypeList -- nonvoid
    | id ws "::" ws pragma? "❲proc❳" ws odinParameterList &procDefinitionBody -- void

  odinParameterList =
    | "(" ws ")" ws -- empty
    | "(" ws lastParameter ")" ws -- single
    | "(" ws notLastParameter+ lastParameter ")" ws -- multiple

  odinReturnType =
    | &procDefinitionBody -- void
    | "->" ws odinReturnTypeList -- typed
  odinReturnTypeList =
    |  "(" ws ")" ws -- empty
    |  "(" ws lastParameter ")" ws -- singlebracketed
    |  "(" ws notLastReturnParameter+ lastReturnParameter ")" ws -- multiple
    | ~"(" singleReturnParameter -- single

  notLastParameter = allocatorOrParameterName anythingButComma "," ws ~")"
  lastParameter = allocatorOrParameterName ~anythingButComma anythingButRPar

  notLastReturnParameter = parameterName? anythingButComma "," ws ~")"
  lastReturnParameter = parameterName? ~anythingButComma anythingButRPar
  singleReturnParameter = ~procDefinitionBody anythingButProcDefinitionBody

  pragma = "#❲force_inline❳" ws

  parameterName =
    | id ws &"," -- sharedtype
    | id ws ":" ws -- named
  allocator =  "❲allocator❳" ws ":=" ws
  allocatorOrParameterName = allocator | parameterName

  bodyStuff = skipTo<"}">
  anythingButComma = skipTo<",">
  anythingButRPar = skipTo<")">
  anythingButProcDefinitionBody = skipTo<procDefinitionBody>

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
}

