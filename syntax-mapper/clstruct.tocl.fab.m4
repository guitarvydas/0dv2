StructdefRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  structdef [id ws1 kcc ws2 kstruct ws3 lb ws4 fields rb] = ‛❪defstruct «id»«ws1»«ws2»⇢\n«ws3»«ws4»«fields»⇠❫\n’

  include(`tokens.fab.inc')
  include(`skim.fab.inc')
}
