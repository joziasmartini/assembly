.globl main

.data

	p_menu: 		.string		"\n\nMenu: \n\n1 - Insert \n2 - Remove by index \n3 - Remove by value \n4 - List \n5 - Exit \n\n"
	p_insert: 		.string         "\nWhat value you want to insert?: "
	p_inserted: 		.string         "\nInserted values: "
	amount_values_entered:  .string 	"\nValues inserted: "
	amount_removed_values:  .string 	"\nValues removed: "

.text

main:					  	# Main function
	
	add s0, zero, sp 		  	# Stack start (lista encadeada)
	jal menu                    		# Jump to the menu function
	
menu:                                     	# Menu functiom

	la a0 , p_menu			  	# Load adress p_menu in a0
	jal print_string              		# Jump to the print_string function	
	jal read_value			 	# Jump to the read_value function (guarda no a0)

	addi s1, zero, 1           		# Add value to register
	addi s2, zero, 2                	# Add value to register
	addi s3, zero, 3                	# Add value to register
	addi s4, zero, 4                	# Add value to register
	addi s5, zero, 5              	 	# Add value to register
	
	beq a0, s1, insert              	# If a0 == s1, skip to insert function
	beq a0, s2, remove_index        	# If a0 == s2, skip to remove_index function
	beq a0, s3, remove_value        	# If a0 == s3, skip to remove_value function
	beq a0, s4, list                	# If a0 == s4, skip to list function
	beq a0, s5, exit                	# If a0 == s5, skip to exit function
	
insert:					 	# Start of the insert function
	
	jal read_value				# Jump to the read_value function
	beq  s0 , sp , insert_first     	# If a0 == sp, skip to insert_first function
	lw t1, 0 (s0)				# Reads the value from memory
	blt  a0 , t1, insert_2     		# If a0 < t1, jump to the insert_2 function
	add t0, zero, s0
	jal insert_3				# Jump to the insert_3 function

insert_first:                       		# First insertion of stack
	
	sw   a0 , 0 ( sp )			# Write to memory, a0 (value), 0 (sp) (memory location)
	sw zero, -4 ( sp )			# Write to memory, zero (value), -4 (sp) (memory location, -4 writes to the second node point (pointer that points to the next node))
	addi  sp , sp , -8
	jal menu				# Jump to the menu function
	
insert_2:					# Insert_2 function
	
	add t1, zero, s0
	sw   a0 , 0 ( sp )			# Write to memory, a0 (value), 0 (sp) (memory location)
	sw t1, -4 ( sp )			# Write to memory, t1 (value), -4 (sp) (memory location, -4 writes to the second node point (pointer that points to the next node))
	add s0, zero, sp
	addi  sp , sp , -8
	jal menu				# Jump to the menu function

insert_3:					# Insert_3 function
	
	lw t1, -4 (t0)				# Reads from memory, t1 (value), -4 (t0) (memory location, -4 writes to the second node point (pointer pointing to the next node))
	beqz t1, insert_array		   	# If t1 = 0, skip to the insert_array function
	lw t2, -0 (t1)
	blt  a0 , t2, insert_array      	# If a0 < t2, jump to the insert_array function
	add t0, zero, t1
	jal insert_3				# Jump to the insert_3 function
	
insert_array:					# Insert_array function
	
	lw t2, -4 (t0)				# Reads from memory, t2 (value), -4 (t0) (memory location, -4 writes to the second node point (pointer pointing to the next node))
	sw a0 , 0 ( sp )			# Write to memory, a0 (value), 0 (sp) (memory location)
	sw t2, -4 ( sp )			# Write to memory, t2 (value), -4 (sp) (memory location, -4 writes to the second node point (pointer that points to the next node))
	sw sp , -4 (t0)				# Write to memory, sp (value), -4 (t0) (memory location, -4 writes to the second node point (pointer that points to the next node))
	addi  sp , sp , -8
	jal menu				# Jump to the menu function

remove_index:                       		# Remove by index function 

	jal read_value				# Jump to the read_value function
	li t1, 0
	jal remove_index_1			# Jump to the remove_index_1 function
	
remove_index_1:					# remove_index_1 function

	beq  s0, sp, menu			# If s0 == sp, skip to menu function
	add t0, zero, s0
	bne  t1 , a0 , remove_index_2		# If t1 != a0, skip to the remove_index_2 function
	lw t2, -4 (t0)				# Reads from memory, t2 (value), -4 (t0) (memory location, -4 writes to the second node point (pointer pointing to the next node))
	add s0, zero, t2
	beqz s0, update_stack			# If s0 = 0, skip to the update_stack function
	jal menu				# Jump to the menu function
	
remove_index_2:					# Remove_index_2 function

	lw t2, -4 (t0)                   	# Reads from memory, t2 (value), -4 (t0) (memory location, -4 writes to the second node point (pointer pointing to the next node))
	beqz t2, menu   			# If t2 = 0, skip to the menu function                       
	addi t1, t1, 1
	bne  t1, a0, remove_index_next		# If t1 != a0, skip to the remove_index_next function
	lw t3, -4 (t2)				# Reads from memory, t3 (value), -4 (t2) (memory location, -4 writes to the second node point (pointer pointing to the next node))
	sw t3, -4 (t0)				# Write to memory, t3 (value), -4 (t0) (memory location, -4 writes to the second node point (pointer that points to the next node))
	jal menu				# Jump to the menu function

remove_index_next:				# Remove_index_next function

	add t0, zero, t2
	jal remove_index_2			# Jump to the remove_index_2 function

remove_value:                              	# Remove by value function

	jal read_value				# Jump to the read_value function
	jal remove_value_two			# Jump to the remove_value_two function

remove_value_two:				# remove_value_two function

	beq  s0 , sp , menu			# If s0 == sp, skip to menu function
	add t0, zero, s0
	lw t1, 0 (t0)				# Reads the value from memory
	bne  t1 , a0 , remove_value_three	# If t1 != a0, skip to the remove_value_three function
	lw t3, -4 (t0)				# Reads from memory, t3 (value), -4 (t0) (memory location, -4 writes to the second node point (pointer pointing to the next node))
	add s0, zero, t3
	beqz s0, update_stack			# If s0 = 0, skip to the update_stack function
	jal remove_value_two			# Jump to the remove_value_two function
	
remove_value_three:				# Remove_value_three function

	lw t1, -4 (t0)                     	# Reads from memory, t1 (value), -4 (t0) (memory location, -4 writes to the second node point (pointer pointing to the next node))
	beqz t1, menu                      	# If t1 = 0, skip to the menu function
	lw t2, 0 (t1)				# Reads the value from memory
	bne  t2 ,   a0 , remove_value_four	# If t2 != a0, skip to the remove_val function
	lw t3, -4 (t1)				# Reads from memory, t3 (value), -4 (t1) (memory location, -4 writes to the second node point (pointer pointing to the next node))
	sw t3, -4 (t0)				# Write to memory, t3 (value), -4 (t0) (memory location, -4 writes to the second node point (pointer that points to the next node))
	jal remove_value_three			# Jump to the remove_value_three function
	
remove_value_four:				# Remove_value_four function

	add t0, zero, t1
	jal remove_value_three			# Jump to the remove_value_three function

update_stack:					# Update_stack function

	add s0, zero, sp
	jal menu				# Jump to the menu function
	
list:                                   	# List all values function
	
	la a0 , p_inserted		  	# Load adress p_inserted in a0
	jal print_string                    	# Jump to the print_string function
	
	add t0, zero, s0
	
	jal list_loop				# Jump to the list_loop function

list_loop:                              	# Loop to read all values

	beqz t0, menu				# If t0 = 0, skip to the menu function
	lw a0 , 0 (t0)				# Reads the value from memory
	jal print_value				# Jump to the print_value function
	lw t0, -4 (t0)				# Reads from memory, t0 (value), -4 (t0) (memory location, -4 writes to the second node point (pointer pointing to the next node))
	jal list_loop				# Jump to the list_loop function

exit:                                    	# Exit function
	la a0, amount_values_entered
	jal print_string			# Jump to the print_string function
	add a0, zero, s1	
	jal print_value				# Jump to the print_value function
	la a0, amount_removed_values
	jal print_string			# Jump to the print_string function
	add a0, zero, s2
	jal print_value				# Jump to the print_value function
	li a7, 10
	ecall
	
	addi    a0, x0, 0                 	# Use 0 return code
	addi    a7, x0, 93                	# Service command code 93 terminates
	ecall                             	# Call linux to terminate the program

read_value:                                 	# Read a int and store to a0 and return to function
	
	li a7, 5
	ecall
	ret                               	

print_value:                                	# Print a int and return to function
	
	li a7, 1
	ecall
	ret                               	

print_string:                                	# Print string in a0 and return to function
	
	li a7, 4
	ecall
	ret                               	
