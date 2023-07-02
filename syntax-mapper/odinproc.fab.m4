OdinProcSignature {
  Program [item+] = ‛«item»’
  Item [i] = ‛«i»’


  Proc [ProcSignature ProcDefinitionBody] = ‛«ProcSignature»«ProcDefinitionBody»’

  ProcDefinitionBody [lb BodyStuff rb] = ‛«lb»«BodyStuff»«rb»’

  ProcSignature_nonvoid [ID kcc Pragma? kproc OdinParameterList OdinReturnTypeList] = ‛«ID»«kcc»«Pragma»«kproc»«OdinParameterList»«OdinReturnTypeList»’
  ProcSignature_void [ID kcc Pragma? kproc OdinParameterList lookahead] = ‛«ID»«kcc»«Pragma»«kproc»«OdinParameterList»’

  OdinParameterList_empty [lp rp] = ‛()’
  OdinParameterList_single [lp LastParameter rp] = ‛(«LastParameter»)’
  OdinParameterList_multiple [lp NotLastParameter+ LastParameter rp] = ‛(«NotLastParameter» «LastParameter»)’

  OdinReturnType_void [lookahead] = ‛’
  OdinReturnType_typed [karrow OdinReturnTypeList] = ‛->«OdinReturnTypeList»’
  OdinReturnTypeList_empty [lp rp] = ‛()’
  OdinReturnTypeList_singlebracketed [lp LastParameter rp] = ‛(«LastParameter»)’
  OdinReturnTypeList_multiple [lp NotLastParameter+ LastParameter rp] = ‛(«NotLastParameter» «LastParameter»)’
  OdinReturnTypeList_single [SingleReturnParameter] = ‛«SingleReturnParameter»’

  NotLastParameter [AllocatorOrParameterName AnythingButComma kcomma] = ‛«AllocatorOrParameterName»«AnythingButComma»«kcomma»’
  LastParameter [AllocatorOrParameterName AnythingButRPar] = ‛«AllocatorOrParameterName»«AnythingButRPar»’

  NotLastReturnParameter [ParameterName? AnythingButComma kcomma] = ‛«ParameterName» «AnythingButComma»,’
  LastReturnParameter [ParameterName? AnythingButRPar] = ‛«ParameterName» «AnythingButRPar»’
  SingleReturnParameter [AnythingButProcDefinitionBody] = ‛«AnythingButProcDefinitionBody»’

  Pragma [kocto force_inline] = ‛#force_inline ’

  ParameterName_sharedtype [ID lookahead] = ‛«ID»,’
  ParameterName_named [ID kcolon] = ‛«ID»:’
  Allocator [kallocator kassign] = ‛allocator :=’
  AllocatorOrParameterName [x] = ‛«x»’

  BodyStuff [stuff] = ‛«stuff»’
  AnythingButComma [stuff] = ‛«stuff»’
  AnythingButRPar [stuff] = ‛«stuff»’
  AnythingButProcDefinitionBody [stuff] = ‛«stuff»’
  
  SkipTo_done [x] = ‛«x»’
  SkipTo_continue [i x] = ‛«i» «x»’
  Inner_nestedparens [l Inner* r] = ‛«l»«Inner»«r»’
  Inner_nestedbraces [l Inner* r] = ‛«l»«Inner»«r»’
  Inner_bottom [AnyToken] = ‛«AnyToken»’

  include(`tokens.fab.inc')
}

