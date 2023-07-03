Odin0Dstruct {
  program [item+] = ‛«item»’
  item [i] = ‛«i»’

  struct [ID kcc ws1 kstruct ws2 lb ws3 NotLastField* LastField rb ws4] = ‛«ID»«kcc»«ws1»«kstruct»«ws2»«lb»«ws3» «NotLastField» «LastField» «rb»⦚«ws4»’

  notLastField [ID kcolon ws1 AnythingButComma kcomma ws2] = ‛«ID»⦚’
  lastField_done [lookahead] = ‛’
  lastField_fieldwithcomma [ID kcolon ws1 AnythingButComma kcomma ws2] = ‛«ID»⦚’
  lastField_fieldnocomma [ID kcolon ws1 AnythingButRBrace] = ‛«ID»⦚’

  anythingButComma [skip ws] = ‛«skip»«ws»’
  anythingButRBrace [skip ws] = ‛«skip»«ws»’

include(`tokens.fab.inc')
  include(`skip.fab.inc')
}
