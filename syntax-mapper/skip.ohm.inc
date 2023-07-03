  SkipTo<stopBefore> =
    | &stopBefore -- done
    | Inner SkipTo<stopBefore> -- continue
  Inner =
    | "(" Inner* ")" -- nestedparens
    | "{" Inner* "}" -- nestedbraces
    | ~"(" ~")" AnyToken -- bottom
