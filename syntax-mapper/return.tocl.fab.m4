Return_Rewrite {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  returnstatement [kreturn ws expr] = ‛\n«ws»«expr»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
}
