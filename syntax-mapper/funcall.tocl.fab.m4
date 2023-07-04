AppendRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’
  funcall [id ws lp anythingButRPar rp] = ‛(«id» «anythingButRPar»)’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')  
}
