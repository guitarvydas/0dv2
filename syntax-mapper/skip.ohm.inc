  skipTo<stopBefore,macro> =
    | &stopBefore -- done
    | macro -- macro
    | inner skipTo<stopBefore,macro> -- continue
  inner =
    | "(" ws inner* ")" -- nestedparens
    | "{" ws inner* "}" -- nestedbraces
    | scopeOpen ws inner* scopeClose -- nestedScope
    | ~"(" ~")" ~"{" ~"}" anyToken -- bottom

  scopeOpen = ab scopebegin ae
  scopeClose = ab scopeend ae
  