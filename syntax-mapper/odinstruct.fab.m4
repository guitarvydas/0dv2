Odin0Dstruct {
  program [item+] = ‛«item»’
  item [i] = ‛«i»’

  struct [ID kcc ws1 kstruct ws2 structype? lb ws3 NotLastField* LastField rb ws4] = ‛\n«ID» :: struct {⇢\n«NotLastField»«LastField»\n}\n’

  structtype [lp ws1 anythingButRPar rp ws2] = ‛’

  notLastField [ID kcolon ws1 AnythingButComma kcomma ws2] = ‛«ID»\n’
  lastField_done [lookahead] = ‛’
  lastField_fieldwithcomma [ID kcolon ws1 AnythingButComma kcomma ws2 lookahead] = ‛⇠«ID»’
  lastField_fieldnocomma [ID kcolon ws1 AnythingButRBrace lookahead] = ‛⇠«ID»’

  anythingButComma [skip ws] = ‛«skip»’
  anythingButRBrace [skip ws] = ‛«skip»’
  anythingButRPar [skip ws] = ‛«skip»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
}
