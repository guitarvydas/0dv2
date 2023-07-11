ProcdefRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  procdef [id ws1 kcc ws2 kproc ws3 lp formals rp ws lb body rb] = ‛(defun «id» («formals»)⇢\n«body»⇠)\n’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
}
