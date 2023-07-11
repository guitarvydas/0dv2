Forin_Rewrite {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  forin [kfor ws1 variable kin ws2 expr lb block rb] =
‛\n❪loop for ❫⇢«variable»❪ in ❫«expr»
    ❪do (progn❫⇢
          «block»❪))❫⇠⇠’
  variable [id ws] = ‛«id»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
}
