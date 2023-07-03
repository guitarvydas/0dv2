  skipTo<stopBefore> =
    | &stopBefore -- done
    | inner skipTo<stopBefore> -- continue
  inner =
    | "(" inner* ")" -- nestedparens
    | "{" inner* "}" -- nestedbraces
    | ~"(" ~")" anyToken -- bottom
