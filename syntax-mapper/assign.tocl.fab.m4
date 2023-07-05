AppendRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  assign [lhs keq ws rhs] = ‛\n(setf «lhs» «rhs»)’
  massign [lhs keq ws rhs] = ‛\n(multiple-value-bind⇢⇢\n(«lhs»)⇠\n«rhs»)⇠’
  lhs [id ws] = ‛«id»«ws»’
  mlhs [id1 ws1 kcomma ws2 id2 ws3] = ‛«id1» «id2»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
}
