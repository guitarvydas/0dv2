ScopedvarRewrite {

  // ⎨scoped ??? x⎬
  //   ...
  // <scope end>
  
  program = item+
  item =
    | scoped
    | any

  scoped = ab sym<"scoped"> ws scopeid ws varid ws ae therest scopeClose

  scopeid = symbol
  varid = symbol
  
  therest = anythingButScopeClose
  anythingButScopeClose = skim<scopeClose,scoped>

  include(`tokensWithAnnotations.ohm.inc')
  include(`skim.ohm.inc')  
  include(`tocl.ohm.inc')
}

