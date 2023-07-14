StructdefRewrite {
  program = item+
  item =
    | structdef
    | any

  structdef = id ws "::" ws "‹struct›" ws "{" fields "}"
  fields = skim<"}",structdef>
  
  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')
}
