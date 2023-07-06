  skipTo<stopBefore,macro> =
    | &stopBefore -- done
    | macro -- macro
    | inner skipTo<stopBefore,macro> -- continue
  inner =
    | "(" ws inner* ")" -- nestedparens
    | "{" ws inner* "}" -- nestedbraces
    | ~"(" ~")" ~"{" ~"}" anyToken -- bottom
