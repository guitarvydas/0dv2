# Syntax Mapping
- attempt at gradually transforming the syntax of one language into the syntax of another language
- one way 
  - round-trip might be harder ; let's just avoid this issue for now
  - it is easier to go from a language with a lot of semantic content ("structure") to a language with less semantic content ("unstructured", e.g. Assembler)
- use Pattern Matching and rewriting
  - Ohm-JS for Pattern Matching
  - FAB for rewriting
  
# First Attempt
- map Python to Common Lisp
- map `x.y` into `(y x)`
- see Makefile
  - see sm.ohm for pattern
  - see sm.fab for rewrite
- run `make` and compare the output with the input `test.py`
- ignore `super()...` for now

## June 26, 2023
- odinproc.ohm
- odinproc2cl.fab
- odinproc2py.fab
- Makefile
- make now produces test2.lisp and test2.py 
  - these ONLY transform proc's and leave everything else alone
- indenter.py uses '(-' and '-)' indentation clues to reformat python code in proper indentation format

## July 4, 2023
- in *.tocl.fab.m4, id is capturing unl/nl with the result that `(setf ... id)` inserts a newline before the `)` - ignoring for now
- might be hard to fix in a general manner
- might just use a post-pass to clean up `\nl)` -> `)\nl`
- undecided
- actually, there should be no unls remaining in the source (just nls) after transpilation

## July 9, 2023
- simplification: add /*tempvar*/ to Odin code
- simplification: assume that multiple assignments are to tempvars only, not globals (allows (multiple-value-bind ...) with local scoping of vars)
- important: matching to end of line implies that generated ")" must be on fresh lines, or must be verbatim
- simplification: remove && and || from Odin code, replace with unrolled 'if' statements

## July 10, 2023
- see https://publish.obsidian.md/programmingsimplicity/2023-07-10-Gradual+Optimization
- see https://publish.obsidian.md/programmingsimplicity/2023-07-10-Towards+Compilation+Using+Textual+Transpilation+(WP)

## July 11, 2023

TODO:
- change spaces back to 2 kinds: src and generated
