StructdefRewrite {
  program = item+
  item =
    | structdef
    | any

  structdef = id ws "::" ws "‹struct›" ws "{" ws fields "}"
  fields = skim<"}",structdef>
  
  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')
}
