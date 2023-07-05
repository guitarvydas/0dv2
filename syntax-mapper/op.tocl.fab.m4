Op_RewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’
  op [idchain ws1 op ws2 expr eolc] = ‛(«op» «idchain» «expr»)«eolc»’

  idchain_rec [idchain kdot ws id] = ‛«idchain».«id»’
  idchain_bottom [id] = ‛«id»’


  include(`tokens.fab.inc')
  include(`skip.fab.inc')  
}
