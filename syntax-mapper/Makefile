all: clean
	make dev

dev: clean
	make pseudo

devandclean: dev
	./cleanup.py <0d.lisp.pseudo >0d.lisp
	cat 0d.lisp

pseudo: 
	./delmacrodefs.sed <../odin/0d/0d.odin \
	| ./macros.py \
	| ./convertws.py \
	| ./fab odincomment.ohm odincomment.fab support.js \
	| ./fab odinproc.ohm odinproc.fab support.js \
	| ./fab odinstruct.ohm odinstruct.fab support.js \
	| ./fab queue.ohm queue.fab support.js \
	| ./fab append.ohm append.fab support.js \
	| ./fab assign.ohm assign.fab support.js \
	| ./fab funcall.ohm funcall.fab support.js \
	| ./intermediateindenter.py >0d.lisp.pseudo

clean:
	rm -f temp*
