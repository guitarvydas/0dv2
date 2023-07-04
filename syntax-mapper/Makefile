#SRC=../../odin0d/0d/0d.odin
SRC=test.odin

all: dev

dev: clean
	make cl

devandclean: dev
	./cleanup.py <0d.lisp.pseudo | ./indenter.py >0d.lisp
	cat 0d.lisp

tokenize:
	./delmacrodefs.sed <$(SRC) \
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

cl: pseudo append.ohm append.tocl.fab message_literal.ohm message_literal.tocl.fab assign.ohm assign.tocl.fab funcall.ohm funcall.tocl.fab
	./fab append.ohm append.tocl.fab support.js <junk--pseudo | tee junk--append \
	| ./fab message_literal.ohm message_literal.tocl.fab support.js | tee junk--ml \
	| ./fab assign.ohm assign.tocl.fab support.js | tee junk--assign \
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

assign.ohm: assign.ohm.m4 tokens.ohm.inc skip.ohm.inc
	m4 assign.ohm.m4 >assign.ohm
assign.tocl.fab: assign.tocl.fab.m4 tokens.fab.inc skip.fab.inc
	m4 assign.tocl.fab.m4 >assign.tocl.fab

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

