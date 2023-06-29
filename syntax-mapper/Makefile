all: dev

dev: clean
	make tokenize

devandclean: dev
	./cleanup.py <0d.lisp.pseudo | ./indenter.py >0d.lisp
	cat 0d.lisp

tokenize:
	./delmacrodefs.sed <../odin/0d/0d.odin \
	| ./macros.py \
	| ./convertws.py \
	| ./fab odincomment.ohm odincomment.fab support.js \
	| cat - >junk-comments

hold:
	| ./fab odinstrings.ohm odinstrings.fab support.js \
	| ./fab odinsymbols.ohm odinsymbols.fab support.js >junk-tokenized

pseudo: tokenize odinproc.ohm odinproc.fab
	./fab odinproc.ohm odinproc.fab support.js <junk-route >junk-pseudo
	./cleanup.py <junk-pseudo | ./indenter.py 

odinproc.ohm:
	m4 odinproc.ohm.m4 >odinproc.ohm

odinproc.fab:
	m4 odinproc.fab.m4 >odinproc.fab

old:
	| ./fab odinproc.ohm odinproc.fab support.js \
	| ./fab odinstruct.ohm odinstruct.fab support.js \
	| ./fab queue.ohm queue.fab support.js \
	| ./fab append.ohm append.fab support.js | tee junk-append \
	| ./fab message_literal.ohm message_literal.fab support.js | tee junk-ml \
	| ./fab assign.ohm assign.fab support.js | tee junk-assign \
	| ./fab funcall.ohm funcall.fab support.js \
	| ./intermediateindenter.py >0d.lisp.pseudo

clean:
	rm -f temp*
	rm -f odinproc.ohm
	rm -f odinproc.fab
	rm -rf junk*
