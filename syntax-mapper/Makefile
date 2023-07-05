#SRC=../../odin0d/0d/0d.odin
SRC=test.odin

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

devandclean: dev
	./cleanup.py <0d.lisp.pseudo | ./indenter.py >0d.lisp
	cat 0d.lisp

tokenize:
	./delmacrodefs.sed <$(SRC) \
	| ./delnoise.sed \
	| ./macros.py \
	| ./convertws.py \
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

cl: pseudo append.ohm append.tocl.fab message_literal.ohm message_literal.tocl.fab assign.ohm assign.tocl.fab funcall.ohm funcall.tocl.fab if.ohm if.tocl.fab forin.ohm forin.tocl.fab forexpr.ohm forexpr.tocl.fab  return.ohm return.tocl.fab op.ohm op.tocl.fab slotvalue.ohm slotvalue.tocl.fab
	./fab append.ohm append.tocl.fab support.js <junk--pseudo | tee junk--append \
	| ./fab message_literal.ohm message_literal.tocl.fab support.js | tee junk--ml \
	| ./fab if.ohm if.tocl.fab support.js | tee junk--if \
	| ./fab forin.ohm forin.tocl.fab support.js | tee junk--forin \
	| ./fab forexpr.ohm forexpr.tocl.fab support.js | tee junk--forexpr \
	| ./fab assign.ohm assign.tocl.fab support.js | tee junk--assign \
	| ./fab funcall.ohm funcall.tocl.fab support.js | tee junk--funcall \
	| ./fab op.ohm op.tocl.fab support.js | tee junk--op \
	| ./fab slotvalue.ohm slotvalue.tocl.fab support.js | tee junk--slotvalue \
	| ./fab return.ohm return.tocl.fab support.js | tee junk--return \
	| cat - >junk--cl
	cat - <junk--cl | ./indenter.py | ./show.py >junk--show
	cat - <junk--cl | ./indenter.py | ./show.py

odinproc.ohm: odinproc.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 odinproc.ohm.m4 >odinproc.ohm
odinproc.fab: odinproc.fab.m4 tokens.fab.inc skip.fab.inc
	m4 odinproc.fab.m4 >odinproc.fab

odinstruct.ohm: odinstruct.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 odinstruct.ohm.m4 >odinstruct.ohm
odinstruct.fab: odinstruct.fab.m4 tokens.fab.inc skip.fab.inc
	m4 odinstruct.fab.m4 >odinstruct.fab

odindeletecomments.ohm: odindeletecomments.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 odindeletecomments.ohm.m4 >odindeletecomments.ohm
odindeletecomments.fab: odindeletecomments.fab.m4 tokens.fab.inc skip.fab.inc
	m4 odindeletecomments.fab.m4 >odindeletecomments.fab

queue.ohm: queue.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 queue.ohm.m4 >queue.ohm
queue.fab: queue.fab.m4 tokens.fab.inc skip.fab.inc
	m4 queue.fab.m4 >queue.fab

append.ohm: append.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 append.ohm.m4 >append.ohm
append.tocl.fab: append.tocl.fab.m4 tokens.fab.inc skip.fab.inc
	m4 append.tocl.fab.m4 >append.tocl.fab

message_literal.ohm: message_literal.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 message_literal.ohm.m4 >message_literal.ohm
message_literal.tocl.fab: message_literal.tocl.fab.m4 tokens.fab.inc skip.fab.inc
	m4 message_literal.tocl.fab.m4 >message_literal.tocl.fab

if.ohm: if.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 if.ohm.m4 >if.ohm
if.tocl.fab: if.tocl.fab.m4 tokens.fab.inc skip.fab.inc
	m4 if.tocl.fab.m4 >if.tocl.fab

forin.ohm: forin.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 forin.ohm.m4 >forin.ohm
forin.tocl.fab: forin.tocl.fab.m4 tokens.fab.inc skip.fab.inc
	m4 forin.tocl.fab.m4 >forin.tocl.fab

forexpr.ohm: forexpr.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 forexpr.ohm.m4 >forexpr.ohm
forexpr.tocl.fab: forexpr.tocl.fab.m4 tokens.fab.inc skip.fab.inc
	m4 forexpr.tocl.fab.m4 >forexpr.tocl.fab

return.ohm: return.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 return.ohm.m4 >return.ohm
return.tocl.fab: return.tocl.fab.m4 tokens.fab.inc skip.fab.inc
	m4 return.tocl.fab.m4 >return.tocl.fab

op.ohm: op.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 op.ohm.m4 >op.ohm
op.tocl.fab: op.tocl.fab.m4 tokens.fab.inc skip.fab.inc
	m4 op.tocl.fab.m4 >op.tocl.fab

assign.ohm: assign.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 assign.ohm.m4 >assign.ohm
assign.tocl.fab: assign.tocl.fab.m4 tokens.fab.inc skip.fab.inc
	m4 assign.tocl.fab.m4 >assign.tocl.fab

slotvalue.ohm: slotvalue.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 slotvalue.ohm.m4 >slotvalue.ohm
slotvalue.tocl.fab: slotvalue.tocl.fab.m4 tokens.fab.inc skip.fab.inc
	m4 slotvalue.tocl.fab.m4 >slotvalue.tocl.fab

funcall.ohm: funcall.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 funcall.ohm.m4 >funcall.ohm
funcall.tocl.fab: funcall.tocl.fab.m4 tokens.fab.inc skip.fab.inc
	m4 funcall.tocl.fab.m4 >funcall.tocl.fab

old:
	| ./fab odinproc.ohm odinproc.fab support.js \
	| ./fab odinstruct.ohm odinstruct.fab support.js \
	| ./fab queue.ohm queue.fab support.js \
	| ./fab append.ohm append.fab support.js | tee junk--append \
	| ./fab message_literal.ohm message_literal.fab support.js | tee junk--ml \
	| ./fab assign.ohm assign.fab support.js | tee junk--assign \
	| ./fab funcall.ohm funcall.fab support.js \
	| ./intermediateindenter.py >0d.lisp.pseudo

clean:
	rm -f temp*
	rm -rf junk--*
	rm -f odinproc.ohm odinproc.fab odinstruct.ohm odinstruct.fab queue.ohm queue.fab append.ohm message_literal.ohm assign.ohm funcall.ohm
	rm -f append.*.fab message_literal.*.fab assign.*.fab funcall.*.fab
	rm -f *~

