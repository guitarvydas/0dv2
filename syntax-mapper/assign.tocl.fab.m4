AppendRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  assign [lhs keq ws rhs] = ‛(setf «lhs» «rhs»)’
  lhs [id ws] = ‛«id»«ws»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
}
