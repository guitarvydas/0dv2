OdinProcSignature {
  program [item+] = ‛«item»’
  item [i] = ‛«i»’


  proc [ProcSignature ProcDefinitionBody] =
‛
«ProcSignature»⇢ {⎨⎧ ❲_❳ ⎬⇢«ProcDefinitionBody»⇠⎨⎭ ❲_❳  ⎬}’

  procDefinitionBody [lb ws1 BodyStuff rb ws2] = ‛«ws1»«BodyStuff»«ws2»’

  procSignature_nonvoid [ID ws0 kcc ws1 Pragma? kproc ws2 OdinParameterList OdinReturnTypeList] = ‛«ID» :: ‹proc› «OdinParameterList»’
  procSignature_void [ID ws0 kcc ws1 Pragma? kproc ws2 OdinParameterList lookahead] = ‛«ID» :: ‹proc› «OdinParameterList»’

  odinParameterList_empty [lp ws1 rp ws2] = ‛()’
  odinParameterList_single [lp ws1 LastParameter rp ws2] = ‛(«LastParameter»)’
  odinParameterList_multiple [lp ws1 NotLastParameter+ LastParameter rp ws2] = ‛(«NotLastParameter» «LastParameter»)’

  odinReturnType_void [lookahead] = ‛’
  odinReturnType_typed [karrow ws1 OdinReturnTypeList] = ‛->«ws1»«OdinReturnTypeList»’
  odinReturnTypeList_empty [lp ws1 rp ws2] = ‛(«ws1»)«ws2»’
  odinReturnTypeList_singlebracketed [lp ws1 LastParameter rp ws2] = ‛(«ws1»«LastParameter»)«ws2»’
  odinReturnTypeList_multiple [lp ws1 NotLastParameter+ LastParameter rp ws2] = ‛(«ws1»«NotLastParameter» «LastParameter»)«ws2»’
  odinReturnTypeList_single [SingleReturnParameter] = ‛«SingleReturnParameter»’

  notLastParameter [AllocatorOrParameterName AnythingButComma kcomma ws1] = ‛«AllocatorOrParameterName»’
  lastParameter [AllocatorOrParameterName AnythingButRPar] = ‛«AllocatorOrParameterName»’

  notLastReturnParameter [ParameterName? AnythingButComma kcomma ws1] = ‛«ParameterName» «AnythingButComma»,«ws1»’
  lastReturnParameter [ParameterName? AnythingButRPar] = ‛«ParameterName» «AnythingButRPar»’
  singleReturnParameter [AnythingButProcDefinitionBody] = ‛«AnythingButProcDefinitionBody»’

  pragma [kfi ws1] = ‛’

  parameterName_sharedtype [ID ws lookahead] = ‛«ID» ’
  parameterName_named [ID ws kcolon ws1] = ‛«ID» ’
  allocator [kallocator ws1 kassign ws2] = ‛’
  allocatorOrParameterName [x] = ‛«x»’

  bodyStuff [stuff] = ‛«stuff»’
  anythingButComma [stuff] = ‛«stuff»’
  anythingButRPar [stuff] = ‛«stuff»’
  anythingButProcDefinitionBody [stuff] = ‛«stuff»’
  
  include(`tokens.fab.inc')
  include(`skip.fab.inc')
}

