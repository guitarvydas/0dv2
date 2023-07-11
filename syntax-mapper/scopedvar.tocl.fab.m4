ScopedvarRewrite {
  program [item+] = ‛«item»’

  scoped [ab kscoped scopeid varid ae therest scopeClose] = ‛(let ((«varid» nil))⇢\n«therest»)\n⇠’
  
  scopeClose [ab scopeend scopeid ae] = ‛«ab»«scopeend»«scopeid»«ae»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
  include(`tocl.fab.inc')
}
