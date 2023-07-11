StructdefRewrite {
  program = item+
  item =
    | structdef
    | any

  structdef = id ws "::" ws "‹struct›" ws "{" fields "}"
  fields = skipTo<"}",structdef>
  
  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')
}
