Odin0Dproc {
  Program [item+] = ‛«item»’
  Item [i] = ‛«i»’

  ProcDef [ID kcc kinline? kproc FormalsList RetList? Whereclause? ProcBody] =
    ‛‹def› «ID» «FormalsList» ⇢«ProcBody»⇠\n’

  Inline [kocto kinline] = ‛«kocto»«kinline»’

  Whereclause [kwhere wherebody] = ‛’

  FormalsList [lp formals* rp] = ‛(❲self «formals»❳)’
  Formal_allocator [kallocator kassign kcontext kdot ID lookahead] = ‛’
  Formal_shorthand [ID kcomma] = ‛«ID» ’
  Formal_other [ID kcolon Type lookahead] = ‛«ID» ’

  nextf [x] = ‛«x»’

  Type [Typestuff+] = ‛«Typestuff»’
  Typestuff_parenthesized [lp Typestuffinner+ rp lookahead] = ‛«lp»«Typestuffinner»«rp»’
  Typestuff_bottom [c lookahead] = ‛«c»’
  Typestuffinner_parenthesized [lp Typestuffinner+ rp] = ‛«lp»«Typestuffinner»«rp»’
  Typestuffinner_bottom [c] = ‛«c»’

  RetList [karrow rettype] = ‛«karrow»«rettype»’
  RetType_multiple [lp Type* rp] = ‛«Type»’
  RetType_single [Type] = ‛«Type»’

  Procbody [lb Bodystuff+ rb] = ‛«Bodystuff»’
  Bodystuff_recursive [lb Bodystuff+ rb] = ‛«lb»«Bodystuff»«rb»’
  Bodystuff_comment [c] = ‛’
  Bodystuff_bottom [c] = ‛«c»’
  Bodystuff_string [s] = ‛«s»’
  Wherebody [Wbodystuff+] = ‛«Wbodystuff»’
  Wbodystuff_comment [c] = ‛’
  Wbodystuff_bottom [c] = ‛«c»’
  Wbodystuff_string [s] = ‛«s»’

  comma [c] = ‛’

  include(`tokens.fab.inc')
}

