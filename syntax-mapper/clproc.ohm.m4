ProcdefRewrite {
  program = item+
  item =
    | procdef
    | any

  procdef = id ws "::" ws "‹proc›" ws "(" formals ")" ws "{" body "}"
  formals = skim<")",procdef>
  body = skim<"}",procdef>
    
  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')
}
