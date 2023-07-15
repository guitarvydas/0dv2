  skim<terminator,userRule> =
    | userRule skim<terminator,userRule>? -- userRule
    | "{" skim<terminator,userRule>* "}"  skim<terminator,userRule>? -- nestedbraces
    | "(" skim<terminator,userRule>* ")"  skim<terminator,userRule>? -- nestedparens
    | scopeOpen skim<terminator,userRule>* scopeClose  skim<terminator,userRule>? -- nestedscope
    | ~bracket any   skim<terminator,userRule>? -- bottom

  bracket = "{" | "}" | "(" | ")" | scopeOpen | scopeClose

  scopeOpen = ab scopebegin ws id ws ae
  scopeClose = ab scopeend ws id ws ae
  