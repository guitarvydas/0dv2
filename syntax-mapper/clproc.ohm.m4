ProcdefRewrite {
  program = item+
  item =
    | procdef
    | any

  procdef = id ws "::" ws "‹proc›" ws "(" formals ")" ws "{" body "}"
  formals = skipTo<")",procdef>
  body = skipTo<"}",procdef>
    
  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')
}
