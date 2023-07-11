// (a(b)c)(d(e)f)

ToRPar {
  Main = "(" ToRPar ")" "(" ToRPar ")"
  ToRPar =
    | &")" -- done
    | "(" ToRPar ")" ToRPar -- parenthesized
    | any ToRPar -- continue
}

// (a,b)
// (d,e,
ToCommaOrRPar {
  Main = "(" ToComma "," ToCommaOrRPar ("," | ")")
  ToComma =
    | &"," -- done
    | "(" ToRPar ")" ToComma -- parenthesized
    | any ToComma -- continue
  ToRPar =
    | &")" -- done
    | "(" ToRPar ")" ToRPar -- parenthesized
    | any ToRPar -- continue
  ToCommaOrRPar =
    | &"," -- donecomma
    | &")" -- donerpar
    | "(" ToRPar ")" ToCommaOrRPar -- parenthesized
    | any ToCommaOrRPar -- continue
}

// (a : u)
ParseTypedParameterList {
  Main = "(" id ":" ToRPar ")"

  ToRPar =
    | &")" -- done
    | "(" ToRPar ")" ToRPar -- parenthesized
    | any ToRPar -- continue
  id = idfirst idrest*
  idfirst = letter | "_"
  idrest = alnum | "_"
}

// ()
// (a : u)
// (b : v, c : w, d : x)
// (a : m(n), b : o(p), c : q(r))
ParseNamedTypedParameterList {
  Main = NamedParameterList
  NamedParameterList =
    | "(" ")" -- empty
    | "(" LastParameter ")" -- single
    | "(" NotLastParameter+ LastParameter ")" -- multiple

  LastParameter = id ":" ToRPar
  NotLastParameter = id ":" ToComma ","
  
  ToRPar = ~"," ToRParHelper
  ToRParHelper =
    | &")" -- done
    | "(" ToRPar ")" ToRPar -- parenthesized
    | any ToRPar -- continue
  ToComma =
    | &"," -- done
    | "(" ToRPar ")" ToComma -- parenthesized
    | any ToComma -- continue

  id = idfirst idrest*
  idfirst = letter | "_"
  idrest = alnum | "_"
}


OdinProcSignature {
  Main = OdinParameterList+
  ProcSignature = id "::" OdinParameterList OdinReturnTypeList?
  OdinParameterList =
    | "(" ")" -- empty
    | "(" LastParameter ")" -- single
    | "(" NotLastParameter+ LastParameter ")" -- multiple
  NotLastParameter = ParameterName AnythingButComma ","
  LastParameter = ParameterName ~AnythingButComma AnythingButRPar
  ParameterName =
    | "allocator" ":=" -- allocator
    | id &"," -- sharedtype
    | id ":" -- named

  OdinReturnTypeList = "->" OdinReturnTypes
  OdinReturnTypes =
    | LastParameter -- single
    | "(" LastParameter ")" -- singleparenthesized
    | "(" NotLastParameter+ LastParameter ")" -- multiple

  AnythingButComma = SkipTo<",">
  AnythingButRPar = SkipTo<")">
  
  SkipTo<stopBefore> =
    | &stopBefore -- done
    | Inner SkipTo<stopBefore> -- continue
  Inner =
    | "(" Inner* ")" -- nested
    | ~"(" ~")" any -- bottom

  id = idFirst idRest*
  idFirst = letter | "_"
  idRest = alnum | "_"
}
