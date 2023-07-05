IfRewriteForCL {
  program [items+] = ‛«items»’

   ifstatement [kif expr lb then rb] = ‛⎨(if ⎬⇢«expr»⎨(progn ⎬⇢«then»⎨)⎬⇠⇠\n»

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
}
