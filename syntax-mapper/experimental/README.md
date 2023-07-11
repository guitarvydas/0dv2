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
- GC is a generalization that makes it easer to Design a program, since you can elide all concerns about allocation and think only about the details of the Design
  - but, generalization produces code that is "less efficient" than a finely-tuned solution for the specific problem
- it is easier to throw information away than it is to infer and insert information,
  - i.e. "round trip" is a difficult goal
  - i.e. "one way transpilation" is much easier than full-blown "round-trip"
  - i.e. if you start with code that handles allocation, you can throw away the type information to make a GC'ed version that is easier to think about
- to design an app, one wants freedom from having to worry about allocation, i.e. one wants a GCed language
- but, to optimize the design, one needs to iterate the designed code to allow it to solve issues of allocatin efficiency
- suggested solution: begin with a loosey-goosey Design and iterate it until it satisfies the needs
  - then, iterate the code, keeping track of provenance from the original Design, to tweak it to allow better efficiency
  - gradually add more type information and iterate, making the type information more precise
  - what do you need to know about a piece of data (a variable)?
	- its name (if any)
	- its semantic type (number, string, user-defined (but not fully specified) type, etc)
	- its machine type (int32, int64, float, double, mutable array of ASCII bytes, mutable array of Unicode bytes, immutable array of ASCII bytes, immutable array of Unicode bytes, machine type signature for every field, etc., etc.)
	- how to allocate it
	- how to clone it
	- how to discard it
   - to keep track of provenance against the original design and to regression-test, use a tool that maps the optimized code back to the GCed code and compare
   
Expected textual manipulation of Odin source code, one step in converting it to Lisp: (see legend below)

```
// Clones the datum portion of the message.
c :: proc(m: Message) -> any {
    /*scopedvar*/ y := h(i)
}

--->

⦚
❲c❳ :: ‹proc› (❲m❳ ) {
⇢
⎧
‹scopedvar›・❲y❳・⟪:=⟫・❲h❳(❲i❳)⦚
⎭
⇠
}

--->

⦚
❲c❳ :: ‹proc› (❲m❳ )⇢ {
⎧
  (let ((❲y❳ nil))
  ⇢
  ・❲y❳・⟪:=⟫・❲h❳(❲i❳)⦚
    ⇢
    ⎧
    ⇠
    ⎭
  ⇠
  ⎭
)
⇠
}
```

Legend:
`❲c❳` symbol ("c")
`‹proc›` keyword symbol ("proc")
`・` space in original source code
`⦚` newline in origina source code
`⟪:=⟫` multiple character operator (":=")
`⇢` formatting command: indent
`⇠` formatting command: dedent
`⎧` edit command: begin edit scope selection (called "narrowing" in emacs)
`⎭` edit command: end edit scope selection

Note:
We probably want to differentiate between *semantic* scopes and *edit* scopes, but, I don't want to go down that rathole yet.

Note that - at this point - we don't care about human readability, we just want to make sure that we've included enough information for the machine to do its job for us.  We can use various syntaxes to elide machine details and to make the code more human-readable.

Note that Odin allows nested comments of the form `/* ... /* ... */ ... */`.

Note that each *semantic scope* is specified by a *name* and an abstract *kind*.

Clearly, using Odin comments as pragmas is not ideal.  A proper uber-language would use keywords / Unicode characters.  The uber-language would map to other languages, like Odin, Python, etc.

Something like the following.
```
c :: proc(m: Message) -> any {
  /*/*beginsemanticscope*/ c proc */
  /*/*scopedvar*/ c y */
  y := h(i)
  /*/*endsemanticscope*/ c */
}
```

The above is nestable, so a scope within a scope might be:
```
c :: proc(m: Message) -> any {
  /*/*beginsemanticscope*/ c proc */
  /*/*scopedvar*/ c y */
  y := h(i)
  z = 7
  /*/*beginsemanticscope*/ c2 proc */
  /*/*scopedvar*/ c2 x */
  x := f(g)
  /*/*endsemanticscope*/ c2 */
  /*/*endsemanticscope*/ c */
}
```

Note: being very, very explicit about various kinds of scoping makes it possible to build a compiler using only text transpilation.

Note: More information about each variable is required (e.g. allocation, freeing, etc.), but, I haven't gone down that rathole yet.
