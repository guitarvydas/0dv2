  skipTo<stopBefore> =
    | &stopBefore -- done
    | inner skipTo<stopBefore> -- continue
  inner =
    | "(" ws inner* ")" ws -- nestedparens
    | "{" ws inner* "}" ws -- nestedbraces
    | ~"(" ~")" anyToken -- bottom
