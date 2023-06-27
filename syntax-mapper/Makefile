all: dev

dev: passes

passes:
	./delmacrodefs.sed <../odin/0d/0d.odin >temp000
	./macros.py <temp000 >temp00
	./fab odincomment.ohm odincomment.fab support.js <temp00 >temp0
	./fab odinproc.ohm odinproc.fab support.js <temp0 >temp1
	./fab odinstruct.ohm odinstruct.fab support.js <temp1 >temp2
	./intermediateindenter.py <temp2 >temp3
