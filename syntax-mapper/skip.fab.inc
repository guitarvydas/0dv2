  skipTo_done [lookahead] = ‛’
  skipTo_continue [i x] = ‛«i»«x»’
  skipTo_macro [x] = ‛«x»’
  inner_nestedparens [l ws1 Inner* r] = ‛«l»«ws1»«Inner»«r»’
  inner_nestedbraces [l ws1 Inner* r] = ‛«l»«ws1»«Inner»«r»’
  inner_bottom [AnyToken] = ‛«AnyToken»’

  scopeOpen  [ab scopebegin ws1 id1 ws2 id2 ws3 ae] = ‛«ab»«scopebegin»«ws1»«id1»«ws2»«id2»«ws3»«ae»’
  scopeClose [ab scopeend   ws1 id1 ws2         ae] = ‛«ab»«scopeend»«ws1»«id1»«ws2»«ae»’
