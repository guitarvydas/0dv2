  skipTo_done [lookahead] = ‛’
  skipTo_continue [i x] = ‛«i» «x»’
  inner_nestedparens [l Inner* r] = ‛«l»«Inner»«r»’
  inner_nestedbraces [l Inner* r] = ‛«l»«Inner»«r»’
  inner_bottom [AnyToken] = ‛«AnyToken»’

