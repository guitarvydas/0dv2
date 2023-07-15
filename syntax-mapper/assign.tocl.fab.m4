AppendRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  assign [lhs ws0 keq ws rhs] = ‛\n❪‹setf› «ws0»«lhs» «ws»«rhs»\n❫\n’
  massign [lhs ws0 keq ws rhs] = ‛\n❪‹multiple-value-bind›⇢⇢\n❪«lhs»❫«ws0»⇠\n«ws»«rhs»\n❫⇠\n’
  lhs [id ws] = ‛«id»«ws»’
  mlhs [id1 ws1 kcomma ws2 id2 ws3] = ‛«id1»«ws1» «ws2»«id2»«ws3»’

  include(`tokens.fab.inc')
  include(`skim.fab.inc')
  include(`tocl.fab.inc')
}
