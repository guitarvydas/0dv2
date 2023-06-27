all: dev

dev: passes

passes:
	./fab odincomment.ohm odincomment.fab support.js <../odin/0d/0d.odin >temp0
	./fab odinproc.ohm odinproc.fab support.js <temp0 >temp1
	./fab odinstruct.ohm odinstruct.fab support.js <temp1 >temp2
	./intermediateindenter.py <temp2 >temp3
