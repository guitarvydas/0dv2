SlotvalueRewrite {
  program = item+
  item =
    | slotvalue -- funcall
    | any -- other

  slotvalue =
    | slotvalue dotc id -- rec
    | id -- bottom

  dotc = "." ws

  include(`tokens.ohm.inc')
}
