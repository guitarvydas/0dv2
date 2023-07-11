  skipTo_done [lookahead] = ‛’
  skipTo_continue [i x] = ‛«i»«x»’
  skipTo_macro [x] = ‛«x»’
  inner_nestedparens [l ws1 Inner* r] = ‛«l»«ws1»«Inner»«r»’
  inner_nestedbraces [l ws1 Inner* r] = ‛«l»«ws1»«Inner»«r»’
  inner_bottom [AnyToken] = ‛«AnyToken»’
