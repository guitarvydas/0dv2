FuncallRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’
  funcall_single [id ws lp notLastArg* lastArg rp] = ‛(«id» «notLastArg»«lastArg»)’
  funcall_indirect [idchain ws lp notLastArg* lastArg rp] = ‛(‹funcall› «idchain» «notLastArg»«lastArg»)’

  notLastArg [stuff kcomma] = ‛«stuff» ’
  lastArg [stuff] = ‛«stuff»’

  include(`tokens.fab.inc')
  include(`skim.fab.inc')
  include(`tocl.fab.inc')
}
