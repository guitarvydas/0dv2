Ifstatement_Rewrite {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  ifstatement [kif expr lb then rb] = ‛⎨(«kif» ⎬⇢«expr»\n⎨(progn⎬⇢\n«then»⎨))⎬⇠⇠’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
}
