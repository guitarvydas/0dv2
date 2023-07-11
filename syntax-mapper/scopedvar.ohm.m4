ScopedvarRewrite {

  // ⎨scoped ??? x⎬
  //   ...
  // <scope end>
  
  program = item+
  item =
    | scoped
    | any

  scoped = ab "scoped" scopeid varid ae therest scopeClose

  scopeid = symbol
  varid = symbol
  
  scopeClose = ab scopeend scopeid ae
  therest = anythingButScopeClose
  anythingButScopeClose = skipTo<scopeClose,scoped>

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
  include(`tocl.ohm.inc')
}

