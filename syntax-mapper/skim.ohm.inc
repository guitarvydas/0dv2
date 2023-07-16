  skim<terminator,userRule> = skim1<terminator,userRule>+
  skim1<terminator,userRule> =
    | userRule -- userRule
    | ~terminator scopeOpen skim<terminator,userRule>* scopeClose -- nestedscope
    | ~terminator compoundToken  -- compoundToken
    | ~terminator "{" skim<terminator,userRule>* "}"  -- nestedbraces
    | ~terminator "(" skim<terminator,userRule>* ")"  -- nestedparens
    | ~terminator any    -- bottom

  skimraw<terminator> = skimraw1<terminator>+
  skimraw1<terminator> =
    | ~terminator scopeOpen skimraw<terminator>* scopeClose -- nestedscope
    | ~terminator compoundToken  -- compoundToken
    | ~terminator "{" skimraw<terminator>* "}"  -- nestedbraces
    | ~terminator "(" skimraw<terminator>* ")"  -- nestedparens
    | ~terminator any    -- bottom

  bracket = "{" | "}" | "(" | ")" | scopeOpen | scopeClose

  scopeOpen = ab scopebegin ws id ws ae
  scopeClose = ab scopeend ws id ws ae
  