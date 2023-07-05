FuncallRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’
  funcall [id ws lp notLastArg* lastArg rp] = ‛(«id» «notLastArg»«lastArg»)’

  idchain_rec [idchain kdot ws id] = ‛«idchain».«id»’
  idchain_bottom [id] = ‛«id»’


  notLastArg [stuff kcomma] = ‛«stuff» ’
  lastArg [stuff] = ‛«stuff»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')  
}
