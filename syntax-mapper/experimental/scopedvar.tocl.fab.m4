ScopedvarRewriteForCL {
  program [items+] = ‛«items»’

  assign [kscopedvar ws1 lhsid ws2 kassign ws3 rhs therest] = ‛\n(‹let› ((«lhsid» nil))⇢\n«ws1»«lhsid»«ws2»«kassign»«ws3»«rhs»«therest»⎨)⎬⇠\n’
  massign [kscopedvar ws1 mlhs ws2 kassign ws3 rhs therest] = ‛«ws2»«mlhs»«ws2»«kassign»«ws3»«rhs»«therest»’

  therest [stuff scopeend] = ‛«stuff»«scopeend»’
  
  mlhs [id1 kcomma ws2 id2] = ‛«id1»,«ws2»«id2»’
  
  tID [id ws] = ‛«id»«ws»’

  include(`tokens.fab.inc')
  include(`skip.fab.inc')
  include(`tocl.fab.inc')
}
