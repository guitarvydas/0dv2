FuncallRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’
  funcall_single [id ws lp notLastArg* lastArg rp] = ‛(«id» «notLastArg»«lastArg»)’
  funcall_indirect [idchain ws lp notLastArg* lastArg rp] = ‛(‹funcall› «idchain» «notLastArg»«lastArg»)’

  idchain_rec [idchain dotc id] = ‛«idchain».«id»’
  idchain_bottom [id] = ‛«id»’
  dotc [kdot ws] = ‛«kdot»«ws»’

  notLastArg [stuff kcomma] = ‛«stuff» ’
  lastArg [stuff] = ‛«stuff»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')

}
