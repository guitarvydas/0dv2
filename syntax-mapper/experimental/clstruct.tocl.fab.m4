StructdefRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  structdef [id ws1 kcc ws2 kstruct ws3 lb fields rb] = ‛(defstruct «id»⇢\n«fields»⇠)\n’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
}
