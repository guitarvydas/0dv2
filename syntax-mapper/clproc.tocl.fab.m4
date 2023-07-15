ProcdefRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  procdef [id ws1 kcc ws2 kproc ws3 lp ws4 formals rp ws lb body rb] = ‛❪defun «id»«ws1»«ws2»«ws3» ❪«ws4»«formals»❫⇢\n«ws»«body»⇠❫\n’

  include(`tokens.fab.inc')
  include(`skim.fab.inc')
}
