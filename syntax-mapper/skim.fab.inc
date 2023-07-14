  skim_done [lookahead] = ‛’
  skim_continue [i x] = ‛«i»«x»’
  skim_macro [x] = ‛«x»’
  inner_nestedparens [l ws1 Inner* r] = ‛«l»«ws1»«Inner»«r»’
  inner_nestedbraces [l ws1 Inner* r] = ‛«l»«ws1»«Inner»«r»’
  inner_nestedscope [scopeopen ws1 Inner* scopeclose] = ‛«scopeopen»«ws1»«Inner»«socpeclose»’
  inner_bottom [AnyToken] = ‛«AnyToken»’

  scopeOpen  [ab scopebegin ws1 id1 ws2 ae] = ‛«ab»«scopebegin»«ws1»«id1»«ws2»«ae»’
  scopeClose [ab scopeend   ws1 id1 ws2 ae] = ‛«ab»«scopeend»«ws1»«id1»«ws2»«ae»’
