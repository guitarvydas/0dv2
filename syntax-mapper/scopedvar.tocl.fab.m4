ScopedvarRewrite {
  program [item+] = ‛«item»’

  scoped [ab kscoped ws1 scopeid ws2 varid ws3 ae therest] =
‛❪let ❪❪«varid» nil❫❫⇢
«therest»❫⇠’
  
  scopeClose [ab scopeend scopeid ae] = ‛«ab»«scopeend»«scopeid»«ae»’

  include(`tokens.fab.inc')
  include(`skim.fab.inc')
  include(`tocl.fab.inc')
}
