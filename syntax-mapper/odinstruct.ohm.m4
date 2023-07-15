Odin0Dstruct {
  program = item+
  item =
    | struct -- struct
    | anyToken -- other

  struct = id ws "⟪::⟫" ws "❲struct❳" ws structtype? "{" ws field* "}"

  structtype = skim<"{",struct>
  field =
    | id ws ":" ws slurp "," ws -- comma
    | id ws ":" ws slurp &"}" -- rbrace

  slurp = skim<commaOrRBrace,struct>

  commaOrRBrace = "," | "}"

  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')  
}
