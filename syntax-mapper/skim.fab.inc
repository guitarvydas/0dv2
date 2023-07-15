  skim_userRule [userRule more?] = ‛«userRule»«more»’
  skim_nestedbraces [lb stuff* rb more?] = ‛«lb»«stuff»«rb»«more»’
  skim_nestedparens [lp stuff* rp more?] = ‛«lp»«stuff»«rp»«more»’
  skim_nestedscope [so stuff* sc more?] = ‛«so»«stuff»«sc»«more»’
  skim_bottom [any+ more?] = ‛«any»«more»’
  
  scopeOpen  [ab scopebegin ws1 id1 ws2 ae] = ‛«ab»«scopebegin»«ws1»«id1»«ws2»«ae»’
  scopeClose [ab scopeend   ws1 id1 ws2 ae] = ‛«ab»«scopeend»«ws1»«id1»«ws2»«ae»’
