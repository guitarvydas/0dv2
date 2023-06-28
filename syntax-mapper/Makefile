all: clean
	make dev

dev: clean
	make pseudo

devandclean: dev
	./cleanup.py <0d.lisp.pseudo

pseudo: 
	./delmacrodefs.sed <../odin/0d/0d.odin >temp000
	./macros.py <temp000 >temp0_
	./convertws.py <temp0_ >temp00
	./fab odincomment.ohm odincomment.fab support.js <temp00 >temp0
	./fab odinproc.ohm odinproc.fab support.js <temp0 >temp1
	./fab odinstruct.ohm odinstruct.fab support.js <temp1 >temp2
	./fab queue.ohm queue.fab support.js <temp2 >temp3
	./fab append.ohm append.fab support.js <temp3 >temp4
	./intermediateindenter.py <temp4 >0d.lisp.pseudo

# py0d: passes
# 	./braces.py <temp3 >temp4
# 	./indenter.py <temp4 >0d.py
# 	# aborted...


clean:
	rm -f temp*
