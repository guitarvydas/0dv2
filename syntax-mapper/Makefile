BIGSRC=../../odin0d/0d/0d.odin
TESTSRC=test.odin
SRC=$(TESTSRC)

# notes: 
# steps: src (Odin syntax) -> tokenize -> pseudo -> cl (to Common Lisp)
# for debugging: capturing all intermediate results in `junk--*` files, which get deleted on every `make dev`
# `junk--tokenized` contains the tokenized file
# `junk--pseudo` contains the file without types (i.e. more human-readable)
# `junk--cl` contains the Common Lisp transpilation, maybe containing transpilation warts
# `junk--show` contains latest/experimental transpiled code with newlines expanded for human readability/debuggability
#
# intention: to convert to .py syntax, we will create non-indented code containing special brackets,
#  then, will indent the code (removing the special brackets) to create Python3-compatible code

all: dev

dev: clean
	make cl

tokenize:
	./delmacrodefs.sed <$(SRC) \
	| ./delnoise.sed \
	| ./macros.py \
	| ./annotations.py \
	| ./convertws.py \
	| ./multi-char-operators.py \
	| ./fab odincomment.ohm odincomment.fab support.js | tee junk--comments \
	| ./fab odinstrings.ohm odinstrings.fab support.js | tee junk--strings \
	| ./fab odinsymbols.ohm odinsymbols.fab support.js >junk--tokenized

deleteComments: tokenize odindeletecomments.ohm odindeletecomments.fab support.js
	./fab odindeletecomments.ohm odindeletecomments.fab support.js <junk--tokenized >junk--nocomments

pseudo: deleteComments odinproc.ohm odinproc.fab odinstruct.ohm odinstruct.fab queue.ohm queue.fab
	./fab odinproc.ohm odinproc.fab support.js <junk--nocomments | tee junk--proc \
	| ./fab odinstruct.ohm odinstruct.fab support.js | tee junk--struct \
	| ./fab queue.ohm queue.fab support.js | tee junk--queue \
	| cat - > junk--pseudo

zero: deleteComments odinproc.ohm odinproc.z odinstruct.ohm odinstruct.z queue.ohm queue.z
	./fab odinproc.ohm odinproc.z support.js <junk--nocomments | tee junk--z-proc >junk--temp
	cat junk--temp >junk--temp2
	@echo '---'
	@echo
	@cat - <junk--temp2  | ./debug-cleanup.py | ./indenter.py | ./show.py | tee junk--show

cl: pseudo append.ohm append.tocl.fab message_literal.ohm message_literal.tocl.fab assign.ohm assign.tocl.fab funcall.ohm funcall.tocl.fab if.ohm if.tocl.fab forin.ohm forin.tocl.fab forexpr.ohm forexpr.tocl.fab  return.ohm return.tocl.fab op.ohm op.tocl.fab slotvalue.ohm slotvalue.tocl.fab \
clstruct.ohm clstruct.tocl.fab clproc.ohm clproc.tocl.fab \
scopedvar.ohm scopedvar.tocl.fab \
delannotations.ohm delannotations.tocl.fab
	./fab append.ohm append.tocl.fab support.js <junk--pseudo | tee junk--append > junk--temp 
	@cat junk--temp >junk--temp2
	./fab message_literal.ohm message_literal.tocl.fab support.js <junk--temp2 | tee junk--ml >junk--temp
	@cat junk--temp >junk--temp2
	./fab if.ohm if.tocl.fab support.js <junk--temp2 | tee junk--if >junk--temp
	@cat junk--temp >junk--temp2
	./fab forin.ohm forin.tocl.fab support.js <junk--temp2 | tee junk--forin >junk--temp
	@cat junk--temp >junk--temp2
	./fab forexpr.ohm forexpr.tocl.fab support.js <junk--temp2 | tee junk--forexpr >junk--temp
	@cat junk--temp >junk--temp2
	./fab scopedvar.ohm scopedvar.tocl.fab support.js <junk--temp2 | tee junk--scopedvar >junk--temp
	@cat junk--temp >junk--temp2
	./fab assign.ohm assign.tocl.fab support.js <junk--temp2 | tee junk--assign >junk--temp
	@cat junk--temp >junk--temp2
	./fab funcall.ohm funcall.tocl.fab support.js <junk--temp2 | tee junk--funcall >junk--temp
	@cat junk--temp >junk--temp2
	./fab op.ohm op.tocl.fab support.js <junk--temp2 | tee junk--op >junk--temp
	@cat junk--temp >junk--temp2
	./fab slotvalue.ohm slotvalue.tocl.fab support.js <junk--temp2 | tee junk--slotvalue >junk--temp
	@cat junk--temp >junk--temp2
	./fab return.ohm return.tocl.fab support.js <junk--temp2 | tee junk--return >junk--temp
	@cat junk--temp >junk--temp2
	./fab clstruct.ohm clstruct.tocl.fab support.js <junk--temp2 | tee junk--clstruct >junk--temp
	@cat junk--temp >junk--temp2
	./fab clproc.ohm clproc.tocl.fab support.js <junk--temp2 | tee junk--clproc >junk--temp
	@cat junk--temp >junk--temp2
	./fab delannotations.ohm delannotations.tocl.fab support.js <junk--temp2 | tee junk--delannotations >junk--temp
	./clean.py  <junk--temp >junk--cl
	@echo '---'
	@echo
	cat - <junk--cl  | ./debug-cleanup.py | ./indenter.py | ./show.py | tee junk--show

odinproc.ohm: odinproc.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 odinproc.ohm.m4 >odinproc.ohm
odinproc.fab: odinproc.fab.m4 tokens.fab.inc skim.fab.inc
	m4 odinproc.fab.m4 >odinproc.fab
odinproc.z: odinproc.z.m4 tokens.fab.inc skim.fab.inc
	m4 odinproc.z.m4 >odinproc.z

odinstruct.ohm: odinstruct.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 odinstruct.ohm.m4 >odinstruct.ohm
odinstruct.fab: odinstruct.fab.m4 tokens.fab.inc skim.fab.inc
	m4 odinstruct.fab.m4 >odinstruct.fab
odinstruct.z: odinstruct.z.m4 tokens.fab.inc skim.fab.inc
	m4 odinstruct.z.m4 >odinstruct.z

odindeletecomments.ohm: odindeletecomments.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 odindeletecomments.ohm.m4 >odindeletecomments.ohm
odindeletecomments.fab: odindeletecomments.fab.m4 tokens.fab.inc skim.fab.inc
	m4 odindeletecomments.fab.m4 >odindeletecomments.fab

queue.ohm: queue.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 queue.ohm.m4 >queue.ohm
queue.fab: queue.fab.m4 tokens.fab.inc skim.fab.inc
	m4 queue.fab.m4 >queue.fab
queue.z: queue.z.m4 tokens.fab.inc skim.fab.inc
	m4 queue.z.m4 >queue.z

append.ohm: append.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 append.ohm.m4 >append.ohm
append.tocl.fab: append.tocl.fab.m4 tokens.fab.inc skim.fab.inc
	m4 append.tocl.fab.m4 >append.tocl.fab

scopedvar.ohm: scopedvar.ohm.m4 tokensWithAnnotations.ohm.inc skim.ohm.inc
	m4 scopedvar.ohm.m4 >scopedvar.ohm
scopedvar.tocl.fab: scopedvar.tocl.fab.m4 tokens.fab.inc skim.fab.inc
	m4 scopedvar.tocl.fab.m4 >scopedvar.tocl.fab

message_literal.ohm: message_literal.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 message_literal.ohm.m4 >message_literal.ohm
message_literal.tocl.fab: message_literal.tocl.fab.m4 tokens.fab.inc skim.fab.inc
	m4 message_literal.tocl.fab.m4 >message_literal.tocl.fab

if.ohm: if.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 if.ohm.m4 >if.ohm
if.tocl.fab: if.tocl.fab.m4 tokens.fab.inc skim.fab.inc
	m4 if.tocl.fab.m4 >if.tocl.fab

forin.ohm: forin.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 forin.ohm.m4 >forin.ohm
forin.tocl.fab: forin.tocl.fab.m4 tokens.fab.inc skim.fab.inc
	m4 forin.tocl.fab.m4 >forin.tocl.fab

forexpr.ohm: forexpr.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 forexpr.ohm.m4 >forexpr.ohm
forexpr.tocl.fab: forexpr.tocl.fab.m4 tokens.fab.inc skim.fab.inc
	m4 forexpr.tocl.fab.m4 >forexpr.tocl.fab

return.ohm: return.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 return.ohm.m4 >return.ohm
return.tocl.fab: return.tocl.fab.m4 tokens.fab.inc skim.fab.inc
	m4 return.tocl.fab.m4 >return.tocl.fab

delannotations.ohm: delannotations.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 delannotations.ohm.m4 >delannotations.ohm
delannotations.tocl.fab: delannotations.tocl.fab.m4 tokens.fab.inc skim.fab.inc
	m4 delannotations.tocl.fab.m4 >delannotations.tocl.fab

op.ohm: op.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 op.ohm.m4 >op.ohm
op.tocl.fab: op.tocl.fab.m4 tokens.fab.inc skim.fab.inc
	m4 op.tocl.fab.m4 >op.tocl.fab

assign.ohm: assign.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 assign.ohm.m4 >assign.ohm
assign.tocl.fab: assign.tocl.fab.m4 tokens.fab.inc skim.fab.inc
	m4 assign.tocl.fab.m4 >assign.tocl.fab

slotvalue.ohm: slotvalue.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 slotvalue.ohm.m4 >slotvalue.ohm
slotvalue.tocl.fab: slotvalue.tocl.fab.m4 tokens.fab.inc skim.fab.inc
	m4 slotvalue.tocl.fab.m4 >slotvalue.tocl.fab

clstruct.ohm: clstruct.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 clstruct.ohm.m4 >clstruct.ohm
clstruct.tocl.fab: clstruct.tocl.fab.m4 tokens.fab.inc skim.fab.inc
	m4 clstruct.tocl.fab.m4 >clstruct.tocl.fab

clproc.ohm: clproc.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 clproc.ohm.m4 >clproc.ohm
clproc.tocl.fab: clproc.tocl.fab.m4 tokens.fab.inc skim.fab.inc
	m4 clproc.tocl.fab.m4 >clproc.tocl.fab

funcall.ohm: funcall.ohm.m4 tokens.ohm.inc skim.ohm.inc
	m4 funcall.ohm.m4 >funcall.ohm
funcall.tocl.fab: funcall.tocl.fab.m4 tokens.fab.inc skim.fab.inc
	m4 funcall.tocl.fab.m4 >funcall.tocl.fab

clean:
	rm -rf junk--*
	rm -f odinproc.ohm odinproc.fab odinstruct.ohm odinstruct.fab queue.ohm queue.fab append.ohm message_literal.ohm assign.ohm funcall.ohm
	rm -f odinproc.z odinstruct.z queue.z
	rm -f append.*.fab message_literal.*.fab assign.*.fab funcall.*.fab
	rm -f *~

indenter-test:
	./indenter.py <indenter-test.fakepy
