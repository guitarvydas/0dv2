all: clean
	make dev

dev: clean
	make pseudo

devandclean: dev
	./cleanup.py <0d.lisp.pseudo | ./indenter.py >0d.lisp
	cat 0d.lisp

tokenize:
	./delmacrodefs.sed <../odin/0d/0d.odin \
	| ./macros.py \
	| ./convertws.py \
	| ./fab odincomment.ohm odincomment.fab support.js \
	| ./fab odinstrings.ohm odinstrings.fab support.js \
	| ./fab odinsymbols.ohm odinsymbols.fab support.js >junk-tokenized
	./cleanup.py <junk-tokenized | ./indenter.py

pseudo: tokenize

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
