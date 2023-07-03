Odin0Dstruct {
  program [item+] = ‛«item»’
  item [i] = ‛«i»’

  struct [ID kcc kstruct lb NotLastField* LastField rb] = ‛«ID» «kcc» «kstruct» «lb» «NotLastField» «LastField» «rb»’

  notLastField [ID kcolon AnythingButComma kcomma] = ‛«ID» ’
  lastField_done [lookahead] = ‛’
  lastField_fieldwithcomma [ID kcolon AnythingButComma kcomma] = ‛«ID»’
  lastField_fieldnocomma [ID kcolon AnythingButRBrace] = ‛«ID»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')  
}
