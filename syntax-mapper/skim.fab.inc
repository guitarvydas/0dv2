  skim [x+] = ‛«x»’
  skim1_userRule [userRule] = ‛«userRule»’
  skim1_compoundToken [tok] = ‛«tok»’
  skim1_nestedbraces [lb stuff* rb] = ‛«lb»«stuff»«rb»’
  skim1_nestedparens [lp stuff* rp] = ‛«lp»«stuff»«rp»’
  skim1_nestedscope [so stuff* sc] = ‛«so»«stuff»«sc»’
  skim1_bottom [any] = ‛«any»’

  skimraw1_compoundToken [tok] = ‛«tok»’
  skimraw1_nestedbraces [lb stuff* rb] = ‛«lb»«stuff»«rb»’
  skimraw1_nestedparens [lp stuff* rp] = ‛«lp»«stuff»«rp»’
  skimraw1_nestedscope [so stuff* sc] = ‛«so»«stuff»«sc»’
  skimraw1_bottom [any] = ‛«any»’
  
  scopeOpen  [ab scopebegin ws1 id1 ws2 ae] = ‛«ab»«scopebegin»«ws1»«id1»«ws2»«ae»’
  scopeClose [ab scopeend   ws1 id1 ws2 ae] = ‛«ab»«scopeend»«ws1»«id1»«ws2»«ae»’
