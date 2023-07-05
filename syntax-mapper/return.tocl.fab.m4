Return_Rewrite {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  returnstatement [kreturn ws expr] = ‛\n«expr»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
}
