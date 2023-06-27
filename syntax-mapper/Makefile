all: dev

dev: comment

preprocess:
	./delmacrodefs.sed <../odin/0d/0d.odin >temp000
	./macros.py <temp000 >temp0_
	./convertws.py <temp0_ >temp00

comment: preprocess
	./fab odincomment.ohm odincomment.fab support.js <temp00 >temp0

passes: comment
	./fab odincomment.ohm odincomment.fab support.js <temp00 >temp0
	./fab odinproc.ohm odinproc.fab support.js <temp0 >temp1
	./fab odinstruct.ohm odinstruct.fab support.js <temp1 >temp2
	./intermediateindenter.py <temp2 >temp3

py0d: passes
	./braces.py <temp3 >temp4
	./indenter.py <temp4 >0d.py
	# aborted...

cl0d: passes
	#./fab pseudo.ohm pseudo2cl.fab support.js <temp3 >0d.lisp

clean:
	rm -f temp*
