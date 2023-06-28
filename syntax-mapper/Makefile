all: clean
	make dev

dev: clean
	make pseudo

devandclean: dev
	./cleanup.py <0d.lisp.pseudo

preprocess:
	./delmacrodefs.sed <../odin/0d/0d.odin >temp000
	./macros.py <temp000 >temp0_
	./convertws.py <temp0_ >temp00

comment: preprocess
	./fab odincomment.ohm odincomment.fab support.js <temp00 >temp0

proc: comment
	./fab odinproc.ohm odinproc.fab support.js <temp0 >temp1
struct: proc
	./fab odinstruct.ohm odinstruct.fab support.js <temp1 >temp2

queue: struct
	# ./queue.bash <temp2 >temp3
	./fab queue.ohm queue.fab support.js <temp2 >temp3

append: queue
	#./append.bash <temp3 >temp4 ## using a REGEX doesn't work as reliably as using a grammar
	./fab append.ohm append.fab support.js <temp3 >temp4

pseudo: append
	./intermediateindenter.py <temp4 >0d.lisp.pseudo

py0d: passes
	./braces.py <temp3 >temp4
	./indenter.py <temp4 >0d.py
	# aborted...

cl0d: passes
	#./fab pseudo.ohm pseudo2cl.fab support.js <temp3 >0d.lisp

clean:
	rm -f temp*
