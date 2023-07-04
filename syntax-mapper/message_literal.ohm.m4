Message_Literal_Rewrite {
  program = item+
  item =
    | message_Literal -- messageliteral
    | any -- other

  message_Literal = sym<"Message"> "(" ws id ws ")" ws "{" ws operand "," ws operand "}" ws

  operand =
    | operand "." id ws -- recursive
    | id ws -- bottom

  include(`tokens.ohm.inc')
}
