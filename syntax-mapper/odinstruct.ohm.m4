Odin0Dstruct {
  program = item+
  item =
    | struct -- struct
    | anyToken -- other

  struct = id ws "⟪::⟫" ws "❲struct❳" ws structtype? "{" ws field+ "}"

  structtype = skim<"{",struct>
  field =
    | id ws ":" ws toComma "," ws
    | id ws ":" ws toRBrace &"}" ws

  toComma = skim<",",struct>
  toRBrace = skim<"}",struct>

  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')  
}
