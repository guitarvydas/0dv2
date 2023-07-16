DelAnnotations_Rewrite {
  program = item+
  item =
    | annotation -- annotation
    | any -- other

  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')
}
