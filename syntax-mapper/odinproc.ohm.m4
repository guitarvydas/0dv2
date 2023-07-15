
OdinProcSignature {
  program = item+
  item =
    | procSignature -- proc
    | anyToken -- other
    
  procSignature =
    | id ws "⟪::⟫" ws pragma? ws "❲proc❳" ws parameterList returnTypeList

  parameterList =
    | "(" notLastParameter* lastParameter? ")"

  returnTypeList = skim<"{",procSignature>

  pragma = "#" ws "❲force_inline❳"

  notLastParameter =
    | id ws ":" ws toComma "," -- id
    | allocToComma "," -- alloc
  lastParameter = 
    | id ws ":" ws toRPar &")" -- id
    | allocToRPar &")" -- alloc

  toComma = skim<",",procSignature>
  toRPar = skim<")",procSignature>

  allocToComma = "❲allocator❳" ws "⟪:=⟫" toComma
  allocToRPar = "❲allocator❳" ws "⟪:=⟫" toRPar


  include(`tokens.ohm.inc')
  include(`skim.ohm.inc')  
}

