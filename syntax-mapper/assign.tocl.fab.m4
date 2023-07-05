AppendRewriteForCL {
  program [items+] = ‛«items»’
  item [x] = ‛«x»’

  assign [lhs ws0 keq ws rhs] = ‛\n(setf «lhs» «rhs»)\n’
  massign [lhs ws0 keq ws rhs] = ‛\n(multiple-value-bind⇢⇢\n(«lhs»)⇠\n«rhs»)⇠\n’
  lhs [id ws] = ‛«id»«ws»’
  mlhs [id1 ws1 kcomma ws2 id2 ws3] = ‛«id1» «id2»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
}
