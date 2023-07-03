Odin0Dstruct {
  Program [item+] = ‛«item»’
  Item [i] = ‛«i»’

  Struct [ID kcc kstruct lb NotLastField* LastField rb] = ‛«ID» «kcc» «kstruct» «lb» «NotLastField» «LastField» «rb»’

  NotLastField [ID kcolon AnythingButComma kcomma] = ‛«ID» ’
  LastField_done [lookahead] = ‛’
  LastField_fieldwithcomma [ID kcolon AnythingButComma kcomma] = ‛«ID»’
  LastField_fieldnocomma [ID kcolon AnythingButRBrace] = ‛«ID»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')  
}
