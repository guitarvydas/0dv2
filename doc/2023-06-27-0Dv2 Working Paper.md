# 0Dv2 Working Paper
## repo
https://github.com/guitarvydas/0dv2
## Goals
- understand minimal Odin 0D implementation that includes state machines
- create a Python version
- create a Common Lisp version
- apply FDD principles - hope to reduce work by using an automatic converter
- modify the minimal Odin 0D code to remove text shortcuts supplied by the Odin language
- back-fill the missing bits (see below)
## What's Missing
- this version does not use the diagram parser
- this version does not use the component Registry
- demo is hard-coded, manually, in text
	- easier to understand what is going on
- full-blown HSMs (Hierarchical State Machines) are not yet written into the code
	- easier to understand, without all of the details of managing the Hierarchy
## Syntax Mapper
- use Ohm-JS + FAB to convert the minimal Odin 0D code into other languages
- manifestation of FDD principles
## Usage
### Odin Test
`cd odin`
`make`
Type in lines of test when prompted.
An empty line quits.
Dump `demo.txt` to see what was typed in.
### Syntax Mapper
`cd syntax-mapper`
`make`
See `temp3` for the converted output.  

Note that, at this time, the conversion is not complete.

Note that the converter uses brackets `(-` and `-)` which, at this time, remain in `temp3`.  We want to use something that cannot be confused with braces and parentheses in the source, but can be formatted by a Lisp pretty-printer, and, can be understood by `indenter.py` and `intermediateindenter.py`.

Note that most of the tools being used rely on *structured text*, i.e. parentheses and braces, instead of Python-esque indentation syntax.  To use these tools, we invent new kinds of brackets `(-` and `-)` that allow us to keep working in *structured text* mode and can be converted - at the last moment - into Python indentation syntax as needed.  To work in this mode, you will see .FAB files that insert the new kinds of brackets into the generated code.  Aside: it is easier to insert such brackets than it is to actually parse indentation (we'll let the Python compiler worry about that).  Aside: Human readability is not a goal, we simply want something that a dumb machine can parse.

## Minor Revelations
- sys is a Container
- current Odin implementation combines Design with Optimization details (Production Engineering)
- it's "easy" to strip information out of code
	- e.g. removing static type information results in a "dynamic" version of the same code
	- I argue that the "dynamic" version of the code makes it easier to understand the Design by pushing Production Engineering details aside and letting the Garbage Collector do the dirty work in a hidden manner
- a Connection is
	1. Sender
	2. Receiver
	3. Direction
	- where Sender is a pair {component x port }
	- where Receiver is a pair {component x port}
	- Direction is one of 4 possibilities
		- Down
		- Up
		- Across
		- Through
	- note that Sender and Receiver *look* the same, but are semantically different when used
	- ENTER and EXIT are implemented as Messages
		- this is an overloading of semantic concepts
		- but, is this overloading a simplification of the concepts?
			- research question: is it possible to write pseudo-code that keeps the 2 concepts separate, but, allows for tighter Production Engineering later?
## Further Details
- understand minimal Odin 0D implementation that includes state machines
	- gain deeper understanding by working on the code
- create a Python version
	- use syntax mapper as first steps
	- write Python-specific steps for final conversion
	- it might not be possible (sensible) to do the conversion 100% automatically, so we might resort to manual fixups at some point
- create a Common Lisp version
	- the CL debugger - Lispworks - is better than most debuggers for static languages
	- use syntax mapper as first steps
	- write CL-specific steps for final conversion
	- it might not be possible (sensible) to do the conversion 100% automatically, so we might resort to manual fixups at some point
- apply FDD principles - hope to reduce work by using an automatic converter
	- in this version, it might not be possible to 100% FDD, so we will decide on-the-fly which parts to do manually and which to do automatically
- modify the minimal Odin 0D code to remove textual shortcuts supported by the Odin language
	- for example `:=` is a shorthand for declaring a variable with a type
	- textual shortcuts are for Humans who insist on writing code in Text form
	- the machine, the compiler doesn't care about textual shortcuts, it is happy to write code the *looks* verbose
		- *normalization* - i.e. possibly verbose, repeated code, boilerplate code - is better for automating compilation/transpilation, since it requires less work for the compiler-writer
		- it is possible to optimize-away boilerplate code using a simple pattern-matching strategy, later - i.e. get the job done, then worry about cleaning it up for optimization (GCC does this, Cordy's Orthogonal Code Generator generalizes the idea)
		- clean-up after-the-fact is sometimes called *peepholing*
			- I've implemented peepholers using simple command-line tools like *sed* and *awk*
			- I believe that Ohm-JS + FAB will make the job of writing a peepholer even easier
	- for example, Odin provides a limited form of *macros*
		- e.g. `fifo_pop :: queue.pop_front_safe` tells the compiler to replace every use of the word `fifo_pop` with `queue.pop_front_safe`
			- this is only a shorthand for Humans which makes the textual code appear to be less verbose
		- this kind of thing is called *symbol macros* in Common Lisp
		- it is easy to replace symbol macros using a Python script
			- or JS, or, M4, or *sed*, or ...
- `example.drawio` contains a diagram that represents the code in odin/demo/main.odin, but, the diagram is not - at this moment - used by the compiler ; the diagram is unchecked and meant for Human eyes
## Research Questions
- should data allocation issues belong to the code, or to the data?
	- Odin makes this problem quite explicit by silently passing a *context* parameter into all procedures
	- OO techniques make it possible to imagine allocation (and reclaiming) being associated with a class
	- Holt, et al, define *data descriptors* that include all details about allocation
		- data descriptors are used in Cordy's Orthogonal Code Generator work
	- *registers* are just memory locations (really, really fast memory)
		- RAM, caches, disk drives, etc. are just variants of memory
		- allocation boils down to caching strategies
		- pure Functional Programming works only with Stacks (parameters, no mutation), hence, deallocation is "free" (i.e. pop the Stack)
		- heaps represent Random Access Memory, deallocation is more difficult and requires edge-cases in the code, and, requires compaction along with other considerations
		- languages that allow Random Access mutation require more careful compilers and edge-cases
		- whereas, languages that are purely functional, allow for simple compilation strategies
			- but, pure functional languages cannot do side-effects - a hallmark of how computer work
			- question: is it possible to relegate mutation to some other kind of syntax which can be combined with pure functional syntax?

