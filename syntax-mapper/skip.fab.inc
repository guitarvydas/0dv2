  SkipTo_done [lookahead] = ‛’
  SkipTo_continue [i x] = ‛«i» «x»’
  Inner_nestedparens [l Inner* r] = ‛«l»«Inner»«r»’
  Inner_nestedbraces [l Inner* r] = ‛«l»«Inner»«r»’
  Inner_bottom [AnyToken] = ‛«AnyToken»’

