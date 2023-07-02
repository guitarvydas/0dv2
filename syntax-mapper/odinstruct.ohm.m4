Odin0Dstruct {
  program = item+
  item =
    | packageDef -- package
    | importDef -- import
    | struct -- struct
    | space -- space
    | any -- other

  importDef =
    | "import" spaces string -- unnamed
    | "import" spaces id spaces string -- named

  packageDef = "package" spaces id

  struct = spaces id spaces "::" spaces "struct" spaces parameterizedtype? spaces "{" spaces typedfield+ "}"

  parameterizedtype = "(" "$" id spaces ":" spaces typechar+ ")"

  typedfield = spaces id spaces ":" spaces type spaces
  type =
    | "#type" spaces "proc" spaces typechar+ -- procref
    | typechar+ -- other

  typechar =
    | "(" typecharinner+ ")" -- parenthesized
    | ~space ~"(" ~")" any -- bottom

  typecharinner =
    | "(" typecharinner+ ")" -- parenthesized
    | ~"(" ~")" any  -- bottom


  id = idfirst idrest*
  idfirst = letter | "_"
  idrest = alnum | "_"
  string = dq (~dq any)* dq
  dq = "\""
  uspc = "・"
  unl = "⦚"
  comment = "//" (~unl any)*
  space := uspc | unl | comment
}