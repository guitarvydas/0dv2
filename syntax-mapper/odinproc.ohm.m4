
OdinProcSignature {
  program = item+
  item =
    | proc -- proc
    | anyToken -- other

  proc = procSignature "{" procBody "}"
  
  procSignature =
    | id ws "⟪::⟫" ws pragma? ws "❲proc❳" ws parameterList returnTypeList

  parameterList =
    | "(" notLastParameter* lastParameter? ")"

  returnTypeList = skim<"{",procSignature>

  pragma = "#" ws "❲force_inline❳"

  notLastParameter =
    | id ws ":" ws toComma "," ws -- id
    | allocToComma "," ws -- alloc
  lastParameter = 
    | id ws ":" ws toRPar ws &")" -- id
    | allocToRPar ws &")" -- alloc

  procBody = skim<"}",proc>

  toComma = skim<",",procSignature>
  toRPar = skim<")",procSignature>

  allocToComma = "❲allocator❳" ws "⟪:=⟫" toComma
  allocToRPar = "❲allocator❳" ws "⟪:=⟫" toRPar


  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')  
}

