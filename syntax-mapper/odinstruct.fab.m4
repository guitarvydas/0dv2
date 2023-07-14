Odin0Dstruct {
  program [item+] = ‛«item»’
  item [i] = ‛«i»’

  struct [ID ws0 kcc ws1 kstruct ws2 structype? lb ws3 NotLastField* LastField rb ws4] = ‛\n«ID» :: ‹struct› {⇢\n«NotLastField»«LastField»\n}\n’

  structtype [lp ws1 anythingButRPar rp ws2] = ‛’

  notLastField [ID ws0 kcolon ws1 AnythingButComma kcomma ws2] = ‛«ID»\n’
  lastField_done [lookahead] = ‛’
  lastField_fieldwithcomma [ID ws0 kcolon ws1 AnythingButComma kcomma ws2 lookahead] = ‛⇠«ID»’
  lastField_fieldnocomma [ID ws0 kcolon ws1 AnythingButRBrace lookahead] = ‛⇠«ID»’

  anythingButComma [skim ws] = ‛«skim»’
  anythingButRBrace [skim ws] = ‛«skim»’
  anythingButRPar [skim ws] = ‛«skim»’

  include(`tokens.fab.inc')
  include(`skim.fab.inc')
}
