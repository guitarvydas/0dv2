all: clean
	make dev

dev: clean
	make pseudo

devandclean: dev
	./cleanup.py <0d.lisp.pseudo

pseudo: 
	./delmacrodefs.sed <../odin/0d/0d.odin \
	| ./macros.py \
	| ./convertws.py \
	| ./fab odincomment.ohm odincomment.fab support.js \
	| ./fab odinproc.ohm odinproc.fab support.js \
	| ./fab odinstruct.ohm odinstruct.fab support.js \
	| ./fab queue.ohm queue.fab support.js \
	| ./fab append.ohm append.fab support.js \
	| ./intermediateindenter.py >0d.lisp.pseudo

clean:
	rm -f temp*
