  skipTo_done [lookahead] = ‛’
  skipTo_continue [i x] = ‛«i»«x»’
  inner_ws [c] = ‛«c»’
  inner_nestedparens [l ws1 Inner* r] = ‛«l»«ws1»«Inner»«r»’
  inner_nestedbraces [l ws1 Inner* r] = ‛«l»«ws1»«Inner»«r»’
  inner_bottom [AnyToken] = ‛«AnyToken»’

