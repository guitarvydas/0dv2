Forexpr_Rewrite {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  forexpr [kfor ws1 expr lb block rb] =
‛\n⎨(loop while ⎬«expr»
    ⎨do (progn⎬⇢
          «block»⎨))⎬⇠⇠’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
}
