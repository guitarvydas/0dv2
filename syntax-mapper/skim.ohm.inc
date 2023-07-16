  skim<terminator,userRule> = skim1<terminator,userRule>+
  skim1<terminator,userRule> =
    | userRule -- userRule
    | ~terminator scopeOpen skim<scopeClose,userRule>* scopeClose -- nestedscope
    | ~terminator compoundToken  -- compoundToken
    | ~terminator "{" skim<"}",userRule>* "}"  -- nestedbraces
    | ~terminator "(" skim<")",userRule>* ")"  -- nestedparens
    | ~terminator any    -- bottom

  skimraw<terminator> = skimraw1<terminator>+
  skimraw1<terminator> =
    | ~terminator scopeOpen skimraw<scopeClose>* scopeClose -- nestedscope
    | ~terminator compoundToken  -- compoundToken
    | ~terminator "{" skimraw<"}">* "}"  -- nestedbraces
    | ~terminator "(" skimraw<")">* ")"  -- nestedparens
    | ~terminator any    -- bottom

  bracket = "{" | "}" | "(" | ")" | scopeOpen | scopeClose

  scopeOpen = ab scopebegin ws id ws ae
  scopeClose = ab scopeend ws id ws ae
  