AssignRewrite {
  program = item+
  item =
    | assign -- assign
    | any -- other

  assign = operand "=" ws operand
  operand =
    | operand "." id ws -- recursive
    | id ws -- bottom

  include(`tokens.ohm.inc')
}
