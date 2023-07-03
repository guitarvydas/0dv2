Odin0Ddeletecomments{
  program = item+
  item =
    | comment -- comment
    | string -- string
    | charconst -- charconst
    | integer -- integer
    | symbol -- symbol
    | any -- other

  include(`tokens.ohm.inc')
}

