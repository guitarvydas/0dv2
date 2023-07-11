  skipTo<stopBefore,macro> =
    | &stopBefore -- done
    | macro -- macro
    | inner skipTo<stopBefore,macro> -- continue
  inner =
    | "(" ws inner* ")" -- nestedparens
    | "{" ws inner* "}" -- nestedbraces
    | scopeOpen ws inner* scopeClose -- nestedScope
    | ~"(" ~")" ~"{" ~"}" anyToken -- bottom

  scopeOpen = ab scopebegin ws id ws id ws ae
  scopeClose = ab scopeend ws id ws ae
  