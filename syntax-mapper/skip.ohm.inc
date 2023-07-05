  skipTo<stopBefore> =
    | &stopBefore -- done
    | inner skipTo<stopBefore> -- continue
  inner =
    | wsc -- ws
    | "(" ws inner* ")" -- nestedparens
    | "{" ws inner* "}" -- nestedbraces
    | ~"(" ~")" ~"{" ~"}" anyToken -- bottom
  