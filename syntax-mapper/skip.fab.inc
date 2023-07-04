  skipTo_done [lookahead] = ‛’
  skipTo_continue [i x] = ‛«i»«x»’
  inner_nestedparens [l ws1 Inner* r ws2] = ‛«l»«ws1»«Inner»«r»«ws2»’
  inner_nestedbraces [l ws1 Inner* r ws2] = ‛«l»«ws1»«Inner»«r»«ws2»’
  inner_bottom [AnyToken] = ‛«AnyToken»’

