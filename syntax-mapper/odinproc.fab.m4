OdinProcSignature {
  program [item+] = ‛«item»’

  proc [signature lb body rb] = ‛«signature»{⎨⎧ ❲_❳ ⎬⇢«body»⇠⎨⎭ ❲_❳  ⎬}’
  procSignature [id ws1 kcc ws2 pragma? ws3 kproc ws4 params returns] =
‛
«id»«ws1»⟪::⟫«ws2»«ws3»‹proc›«ws4»«params» ’

  parameterList [lp notLastParameters* lastParameter? rp] = ‛❪«notLastParameters»«lastParameter»❫’

  pragma [koctothorpe ws kinline] = ‛’
  notLastParameter_id [id ws1 kcolon ws2 typestuff kcomma ws3] = ‛ «id»’
  notLastParameter_idsharedtype [id ws1 kcomma ws3] = ‛ «id»«ws1»«ws3»’
  notLastParameter_alloc [stuff kcomma ws1] = ‛’
  lastParameter_id [id ws1 kcolon ws2 typestuff ws3 lookahead] = ‛ «id»’
  lastParameter_alloc [stuff ws1 lookahead] = ‛’

  allocToComma [kallocator ws1 kceq stuff] = ‛’
  allocToRPar [kallocator ws1 kceq stuff] = ‛’

  include(`tokens.fab.inc')
  include(`skim.fab.inc')
}

