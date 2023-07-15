  skim<terminator,userRule> =
    | userRule skim<terminator,userRule>? -- userRule
    | ~terminator "{" skim<terminator,userRule>* "}"  skim<terminator,userRule>? -- nestedbraces
    | ~terminator "(" skim<terminator,userRule>* ")"  skim<terminator,userRule>? -- nestedparens
    | ~terminator scopeOpen skim<terminator,userRule>* scopeClose  skim<terminator,userRule>? -- nestedscope
    | ~terminator (~bracket any)+   skim<terminator,userRule>? -- bottom

  bracket = "{" | "}" | "(" | ")" | scopeOpen | scopeClose

  scopeOpen = ab scopebegin ws id ws ae
  scopeClose = ab scopeend ws id ws ae
  