  skim<terminator,userRule> = skim1<terminator,userRule>+
  skim1<terminator,userRule> =
    | userRule -- userRule
    | ~terminator scopeOpen skim<terminator,userRule>* scopeClose -- nestedscope
    | ~terminator compoundToken  -- compoundToken
    | ~terminator "{" skim<terminator,userRule>* "}"  -- nestedbraces
    | ~terminator "(" skim<terminator,userRule>* ")"  -- nestedparens
    | ~terminator any    -- bottom

//   skim<terminator,userRule> =
//     | userRule skim<terminator,userRule>? -- userRule
//     | ~terminator scopeOpen skim<terminator,userRule>* scopeClose  skim<terminator,userRule>? -- nestedscope
//     | ~terminator compoundToken skim<terminator,userRule>? -- compoundToken
//     | ~terminator "{" skim<terminator,userRule>* "}"  skim<terminator,userRule>? -- nestedbraces
//     | ~terminator "(" skim<terminator,userRule>* ")"  skim<terminator,userRule>? -- nestedparens
// //    | (~terminator ~bracket ???compoundToken??? ???userRule??? any)+   skim<terminator,userRule>? -- bottom
//     | ~terminator any   skim<terminator,userRule>? -- bottom

  bracket = "{" | "}" | "(" | ")" | scopeOpen | scopeClose

  scopeOpen = ab scopebegin ws id ws ae
  scopeClose = ab scopeend ws id ws ae
  