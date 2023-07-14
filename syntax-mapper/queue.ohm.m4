QueueRewrite {
  program = item+
  item =
    | pushOrPop
    | any

  pushOrPop = push | pop
  push = "❲queue❳" ws "." ws "❲push_back❳" ws "(" ws "&" ws notlastoperand "," ws lastoperand ")"
  pop = "❲queue❳" ws "." ws "❲pop_front_safe❳" ws "(" ws "&" ws lastoperand ")"

  notlastoperand = anythingButComma &","
  lastoperand = anythingButRPar ws

  anythingButComma = skim<",",pushOrPop> ws
  anythingButRPar = skim<")",pushOrPop> ws

  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')  
  
}
