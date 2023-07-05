AppendRewrite {
  program = item+
  item =
    | append -- append
    | any -- other

  append = sym<"append"> "(" ws "&" ws operand "," ws operand ")"
  operand =
    | operand "." id ws -- recursive
    | id ws -- bottom

  include(`tokens.ohm.inc')
}
