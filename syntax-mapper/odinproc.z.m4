OdinProcSignature {
  program [x+] = ‛«x»’
  item_proc [x] = ‛«x»’
  item_other [x] = ‛«x»’
		  

  proc [signature lb body rb] = ‛«lb»«body»«rb»’
  procSignature [id ws1 kcc ws2 pragma? ws3 kproc ws4 params returns] =
‛
«id»«ws1»⟪::⟫«ws2»«ws3»‹proc›«ws4»«params» ’

  parameterList [lp notLastParameters* lastParameter? rp] = ‛❪«notLastParameters»«lastParameter»❫’

  pragma [koctothorpe ws kinline] = ‛’
  notLastParameter_id [id ws1 kcolon ws2 typestuff kcomma] = ‛ «id»’
  notLastParameter_alloc [stuff kcomma] = ‛’
  lastParameter_id [id ws1 kcolon ws2 typestuff krpar] = ‛ «id»’
  lastParameter_alloc [stuff klpar] = ‛’

  allocToComma [kallocator ws1 kceq stuff] = ‛’
  allocToRPar [kallocator ws1 kceq stuff] = ‛’

  include(`tokens.fab.inc')
  include(`skim.fab.inc')
}

