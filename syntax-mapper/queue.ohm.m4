QueueRewrite {
  program = item+
  item =
    | push -- push
    | pop -- pop
    | any -- other

  push = "❲queue❳" ws "." ws "❲push_back❳" ws "(" ws "&" ws notlastoperand lastoperand ")" ws
  pop = "❲queue❳" ws "." ws "❲pop_front_safe❳" ws "(" ws "&" ws lastoperand ")" ws

  notlastoperand = anythingButComma "," ws
  lastoperand = anythingButRPar ws

  anythingButComma = skipTo<","> ws
  anythingButRPar = skipTo<")"> ws

  include(`tokens.ohm.inc')
  include(`skip.ohm.inc')  
  
}
