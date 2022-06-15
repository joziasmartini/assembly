# Complete code of the expression
# S = ((C - B) / ((A - C) * D))

.data

A:	.word	  18
B:	.word 	11
C: 	.word 	14
D: 	.word 	6
S: 	.word 	10

.text

main:
	lw a0, A
	lw a1, B
	lw a2, C
	lw a3, D
	lw a4, S	

	sub a5, a2, a1 # Ok
	sub a6, a0, a2
	mul a7, a6, a3
	div a4, a5, a7