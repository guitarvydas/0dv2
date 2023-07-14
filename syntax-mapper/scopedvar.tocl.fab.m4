ScopedvarRewrite {
  program [item+] = ‛«item»’

  scoped [ab kscoped ws1 scopeid ws2 varid ws3 ae therest scopeClose] =
‛⎨⎧ ❲_❳ ⎬
❪(let ((«varid» nil))❫⇢
«therest»❪)❫
⇠⎨⎭ ❲_❳  ⎬
«scopeClose»
’
  
  scopeClose [ab scopeend scopeid ae] = ‛«ab»«scopeend»«scopeid»«ae»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
  include(`tocl.fab.inc')
}
