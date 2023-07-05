Op_Rewrite {
  program = item+
  item =
    | op
    | any

  op = idchain ws operator expr
  idchain_rec [idchain kdot ws id] = ‛«idchain».«id»’
  idchain_bottom [id] = ‛«id»’
  expr = anythingButEOL

  anythingButEOL = skipTo<srcnl>

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')
}
