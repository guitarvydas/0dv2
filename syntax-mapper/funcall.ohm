FuncallRewriteForCL {
  program = item+
  item =
    | applySyntactic<Funcall> -- funcall
    | any -- other

  Funcall =
    | Funcid Args -- quoted
    | Operand Args -- evaled

  Funcid =
    | id
    
  Args = "(" Arg* ")"

  Arg =
    | "Message_Literal" "(" Stuff ")" -- messageliteral
    | Operand -- arg
  
  Operand =
    | Operand "." id -- recursive
    | id -- bottom

  Stuff =
    | "(" Stuff ")" Stuff? -- recursive
    | ~"(" ~")" Operand Stuff? -- bottom
    
  id = idfirst idrest*
  idfirst = letter | "_"
  idrest = alnum | "_"
  comma = ","
  string = dq (~dq any)* dq
  dq = "\""
  uspc = "・"
  unl = "⦚"
  space += uspc | unl | comma
}
