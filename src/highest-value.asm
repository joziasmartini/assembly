.data
  a: .word 3
  b: .word 4
  c: .word 5
	
.text
  lw t0, a               #load a in t0
  lw t1, b               #load b in t1
  lw t2, c               #load c in t2
	
  bge t0, t1, test       #t0 > t1?

test:
  bge t0, t2, a_end      #t0 is >
  j verify	

verify:	
  bge t1, t2, b_end      #t1 is >	
  bge t2, t0, c_end      #t2 is >	      

a_end:
  add a0, zero, t0       #add t0 in a0
  j exit

b_end:
  add a0, zero, t1       #add t1 in a0
  j exit
	
c_end: 
  add a0, zero, t2       #add t2 in a0
  j exit
  
exit:
  nop
