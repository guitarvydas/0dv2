AppendRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’
  funcall [id ws lp notLastArg* lastArg rp] = ‛(«id» «notLastArg»«lastArg»)’

  notLastArg [stuff kcomma] = ‛«stuff» ’
  lastArg [stuff] = ‛«stuff»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')  
}
