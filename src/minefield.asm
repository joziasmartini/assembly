# Jozias Martini
# Hesron Bressiani

.data

# Where the fields are stored in memory (in bytes) 
# (the first field is at address 0)
# (the second field is at address 4)
# (the third field is at address 8)
# Because the fields are 4 bytes long
# And are stored in the data segment
interface:
	.word   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	.word   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	.word   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	.word   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	.word   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	.word   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	.word   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	.word   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	.word   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	.word   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	.word   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	.word   -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1	
  
# A função insere_bombas necessita os seguintes rótulos e espaços de memória
campo:									.space 		576 
salva_S0: 							.word 		0 
salva_ra: 							.word 		0 
newLine: 								.string 	"\n"
printHyphen: 						.string 	" - "
gameTitle:			      	.string		"\nCampo Minado\n\n"
firstMenuTitle:			  	.string		"Escolha o tamanho do campo: \n"
firstMenuFirstOpt:			.string		"8 - 8x8 \n"
firstMenuSecondOpt:			.string		"10 - 10x10 \n"
firstMenuThirdOpt:			.string		"12 - 12x12 \n"
menuChooseOpt:			  	.string		"Digite o número da opção: "
secondMenuTitle: 		    .string		"\nEscolha uma das opções abaixo:\n"
secondMenuFirstOption:	.string		"1 - Abrir campo\n"
secondMenuSecondOption:	.string		"2 - Inserir bandeira\n"
thirdMenuFirstOpt:		  .string		"Insira o valor da linha:"
thirdMenuSecondOpt:		  .string		"Insira o valor da coluna:"
userWins:								.string		"\nParabéns, você venceu!\n"
userLoses:							.string		"\nOh não, você perdeu!\n"
printSpace:							.string		" "

.text

main:
	# Constant area
	addi s5, zero, 9
	addi s6, zero, 1
	addi s11, zero, -1
	
	# Call the function where user chooses the size of the field
	jal matriz_length_choose_menu  

	# Call the function where the field is loaded
	la s10, interface

	# Call the function where the bombs are inserted
	la a0, campo # Load the field
	add a1, zero, a2 # Matrix size
	jal insere_bombas # Send the two parameters above to the function

	# Call the function where the bombs are calculated
	la a0, campo
	add a1, zero, a2
	jal calcula_bombas

	# Show the field to the user
	jal mostra_campo

gameplay_menu:
	la		    a0, secondMenuTitle # Print "escolha uma das opções abaixo"
	li 		    a7, 4
	ecall

	la		    a0, secondMenuFirstOption # Print "abrir campo"
	li 		    a7, 4
	ecall
	
	la		    a0, menuChooseOpt # Print "digite o número da opção"
	li 		    a7, 4
	ecall

	li  		a7, 5 # Read the user input
	ecall

	jal	lineColumnMenu # Call the function where the user chooses the line and column

	la 	    	a0, campo           # Campo
	la			a1, interface		# Interface
	jal open_position

	la s10, interface
	jal mostra_campo

	j gameplay_menu

calcula_bombas:	# Calculates the number of bombs around each cell
	addi s2, a1, -1 # s2 = a1 - 1, that is: line numbers - 1
	add t2, zero, zero # Variable that runs through the lines

	for_lineCalc: # Loop that runs through the lines
		addi t3, zero, -1 # Resets the loop variable that runs through the columns				
		beq t2, a1, for_lineCalcEnd #

	for_columnCalc: # Loop that runs through the columns
		add s0, zero, zero
		addi t3, t3, 1 
		beq t3, a1, for_columnCalcEnd # If t3 == a1, then the loop ends

		mul s1, t2, a1 # s1 = t2 * a1, that is: line number * column number 
		add s1, s1, t3 # s1 = s1 + t3, that is: s1 + column number
		addi a5, zero, 4 # a5 = 4, that is: the size of each cell in the field
		mul s1, s1, a5 # s1 = s1 * a5, that is: s1 * 4, that is: the position of the cell in the field

		add s3, s1, a0 # s3 = s1 + a0, that is: the position of the cell in the field + the field address
		lw  s3, 0(s3) # s3 = the value of the cell in the field
		
		bne s3, s5, cima_esquerda # If the cell is not a bomb, then check the cell above and to the left
		j for_columnCalc # If the cell is a bomb, then go to the next cell

	cima_esquerda: # Checks the cell above and to the left
		addi s3, s1, -4 
		addi s3, s3, -32 
		add s3, a0, s3 
		lw  s3, 0(s3)

		beq t2, zero, centro_cima 
		beq t3, zero, centro_cima 
		bne s3, s5, centro_cima 
		addi s0, s0, 1 

	centro_cima: # Checks the cell above
		addi s3, s1, -32 
		add s3, s3, a0 
		lw  s3, 0(s3)

		beq t2, zero, cima_direita 
		bne s3, s5, cima_direita 
		addi s0, s0, 1 

	cima_direita: # Checks the cell above and to the right
		addi s3, s1, 4 
		addi s3, s3, -32 
		add s3, s3, a0 
		lw  s3, 0(s3)
		
		beq t3, s2, centro_esquerda 
		beq t2, zero, centro_esquerda 
		bne s3, s5, centro_esquerda 
		addi s0, s0, 1 

	centro_esquerda: # Checks the cell to the left
		addi s3, s1, -4 
		add s3, s3, a0 
		lw  s3, 0(s3)
		
		beq t3, zero, centro_direita 
		bne s3, s5, centro_direita 
		addi s0, s0, 1 

	centro_direita: # Checks the cell to the right
		addi s3, s1, 4 
		add s3, s3, a0 
		lw  s3, 0(s3)
		
		beq t3, s2, baixo_esquerda 
		bne s3, s5, baixo_esquerda 
		addi s0, s0, 1 

	baixo_esquerda: # Checks the cell below and to the left
		addi s3, s1, -4 
		addi s3, s3, 32 
		add s3, s3, a0 
		lw  s3, 0(s3)

		beq t3, zero, centro_baixo 
		beq t2, s2, centro_baixo 
		bne s3, s5, centro_baixo 
		addi s0, s0, 1 

	centro_baixo: # Checks the cell below
		addi s3, s1, 32 
		add s3, s3, a0 
		lw  s3, 0(s3)
		
		beq t2, s2, baixo_direita 
		bne s3, s5, baixo_direita 
		addi s0, s0, 1 

	baixo_direita: # Checks the cell below and to the right
		addi s3, s1, 4 
		addi s3, s3, 32 
		add s3, s3, a0 
		lw  s3, 0(s3)

		beq t3, s2, continua_verificacao
		beq t2, s2, continua_verificacao
		bne s3, s5, continua_verificacao 
		addi s0, s0, 1 

	continua_verificacao: # Saves the number of bombs around the cell in the field
		add s3, s1, a0 # Field address that will be replaced by the bomb number
		sw  s0, 0(s3) # Saves the bomb number in the field
		j for_columnCalc # Goes to the next cell

	for_columnCalcEnd: 
		addi t2, t2, 1 # t2 = t2 + 1, that is: line number + 1
		j for_lineCalc # Goes to the next line

	for_lineCalcEnd:
    ret # Returns to the main function

lineColumnMenu: # Function that asks the user for the line and column
	la a0, thirdMenuFirstOpt # Print "digite a linha"
	li a7, 4
	ecall

	li a7, 5
	ecall
	add s3, zero, a0

	la a0, thirdMenuSecondOpt # Print "digite a coluna"
	li a7, 4
	ecall

	li a7, 5 # Read the user input
	ecall
	add s4, zero, a0 # Save the user input in s4

	ret

matriz_length_choose_menu: # Function that asks the user for the matrix length
  	la a0, gameTitle # Print "campo minado"
	li a7, 4              
	ecall 
	
	la a0, firstMenuTitle # Print "escolha o tamanho do campo"
	li a7, 4
	ecall
	
	la a0, firstMenuFirstOpt # Print "8x8"
	li a7, 4
	ecall
	
	la a0, firstMenuSecondOpt # Print "10x10"
	li a7, 4
	ecall
	
	la a0, firstMenuThirdOpt # Print "12x12"
	li a7, 4
	ecall
	
	la a0, menuChooseOpt # Print "digite o número da opção"
	li a7, 4
	ecall
	
	li a7, 5 # Read the user input
	ecall
  	
	add a2, zero, a0 # Save the user input in a2

  ret

mostra_campo:
	addi a4, zero, 0 # Iterator of line
	addi a5, zero, 0 # Iterator of column
	
	for_line: # For each line
		beq a4, a2, exit

	for_column: # For each column
		beq a5, a2, reset_for_column

		lw a6, 0(s10) # Load the value of the cell
		beq a6, s11, print_value_one # If the value is -1, print a space

		la a0, printSpace # Print hyphen if the value is -1
		li a7, 4
		ecall

		li a7, 1
		add a0, zero, a6
		ecall

		la a0, printSpace # Print hyphen if the value is -1
		li a7, 4
		ecall

		addi s10, s10, 4
		addi a5, a5, 1

		j for_column               

	print_value_one:
		la a0, printHyphen # Print hyphen if the value is -1
		li a7, 4
		ecall

		addi s10, s10, 4 # Increment the pointer to the next cell
		addi a5, a5, 1 # Increment the column iterator

		j for_column # Go to the next column

	reset_for_column: # Reset the column iterator
		la a0, newLine # Print a new line
		li a7, 4
		ecall

		addi a5, zero, 0 # Reset the column iterator
		addi a4, a4, 1 # Increment the line iterator
		j for_line # Go to the next line

open_position:
	# s3 => linha
	# s4 => coluna
	# a0 => campo
	# a1 => interface

	mul s1, s3, a2
	add s1, s1, s4
	addi a5, zero, 4
	mul s1, s1, a5

	add a0, a0, s1

	lw s0, 0(a0)

	beq s0, s5, usuario_perdeu

	add a1, a1, s1

	sw s0, 0(a1)

	ret

usuario_venceu: # If the user wins
	la a0, userWins # Print the user wins message
	li a7, 4
	ecall # System call to print the message
	j end

usuario_perdeu: # If the user loses
	la a0, userLoses # Print the user loses message
	li a7, 4
	ecall # System call to print the message
	j end















#########################################################
# necessário em caso de debug da funcao
#espaco:			.asciz		" "
#dois_pontos:		.asciz		": "
#nova_linha:		.asciz		"\n"
#posicao:		.asciz		"\nPosicao bomba "
#########################################################
############################################################
# A função insere_bombas está implementada abaixo.
# Todo o código a seguir, mais os rotulos acima deve 
# ser colocado junto ao código do trabalho de campo minado
# entrada: a0 endereço de memoria do inicio da matriz campo
#          a1 quantidade de linhas da matriz campo
# saida: nao retorna nada
############################################################
#     Algoritmo	
#
#  Salva registradores
#  Carrega numero de sementes sorteadas = 15
#  Le semente para função de numero pseudo randomico
#  while (bombas < x) 
#     sorteia linha
#     sorteia coluna
#     le posição pos = (L * tam + C) * 4
#     if(pos != 9)
#    	  grava posicao pos = 9
#     bombas++  
#
############################################################
insere_bombas:
		la		t0, salva_S0
		sw  	s0, 0 (t0) # salva conteudo de s0 na memoria
		la		t0, salva_ra
		sw  	ra, 0 (t0) # salva conteudo de ra na memoria
		
		add 	t0, zero, a0 # salva a0 em t0 - endereço da matriz campo
		add 	t1, zero, a1 # salva a1 em t1 - quantidade de linhas 

QTD_BOMBAS:
		addi 	t2, zero, 15 # seta para 15 bombas	
		add 	t3, zero, zero # inicia contador de bombas com 0
		addi 	a7, zero, 30 # ecall 30 pega o tempo do sistema em milisegundos (usado como semente
		ecall 				
		add 	a1, zero, a0 # coloca a semente em a1
INICIO_LACO:
		beq 	t2, t3, FIM_LACO
		add 	a0, zero, t1 # carrega limite para %	(resto da divisão)
		jal 	PSEUDO_RAND
		add 	t4, zero, a0 # pega linha sorteada e coloca em t4
		add 	a0, zero, t1 # carrega limite para % (resto da divisão)
   	jal 	PSEUDO_RAND
		add 	t5, zero, a0 # pega coluna sorteada e coloca em t5

###############################################################################
# imprime valores na tela (para debug somente) - retirar comentarios para ver
#	
#		li	a7, 4		# mostra texto "Posicao: "
#		la	a0, posicao
#		ecall
#		
#		li	a7, 1		
#		add 	a0, zero, t3 	# imprime quantidade ja sorteada
#		ecall		
#
#		li	a7, 4		# imrpime :
#		la	a0, dois_pontos
#		ecall
#
#		li	a7, 1
#		add 	a0, zero, t4 	# imprime a linha sorteada	
#		ecall
#		
#		li	a7, 4		# imrpime espaço
#		la	a0, espaco
#		ecall	
#			
#		li	a7, 1
#		add 	a0, zero, t5 	# imprime coluna sorteada
#		ecall
#		
##########################################################################	

LE_POSICAO:	
		mul  	t4, t4, t1
		add  	t4, t4, t5  		# calcula (L * tam) + C
		add  	t4, t4, t4  		# multiplica por 2
		add  	t4, t4, t4  		# multiplica por 4
		add  	t4, t4, t0  		# calcula Base + deslocamento
		lw   	t5, 0(t4)   		# Le posicao de memoria LxC
VERIFICA_BOMBA:		
		addi 	t6, zero, 9		# se posição sorteada já possui bomba
		beq  	t5, t6, PULA_ATRIB	# pula atribuição 
		sw   	t6, 0(t4)		# senão coloca 9 (bomba) na posição
		addi 	t3, t3, 1		# incrementa quantidade de bombas sorteadas
PULA_ATRIB:
		j	INICIO_LACO

FIM_LACO:					# recupera registradores salvos
		la	t0, salva_S0
		lw  	s0, 0(t0)		# recupera conteudo de s0 da memória
		la	t0, salva_ra
		lw  	ra, 0(t0)		# recupera conteudo de ra da memória		
		jr 	ra			# retorna para funcao que fez a chamada
		
##################################################################
# PSEUDO_RAND
# função que gera um número pseudo-randomico que será
# usado para obter a posição da linha e coluna na matriz
# entrada: a0 valor máximo do resultado menos 1 
#             (exemplo: a0 = 8 resultado entre 0 e 7)
#          a1 para o número pseudo randomico 
# saida: a0 valor pseudo randomico gerado
#################################################################
#int rand1(int lim, int semente) {
#  static long a = semente; 
#  a = (a * 125) % 2796203; 
#  return (|a % lim|); 
# }  

PSEUDO_RAND:
		addi t6, zero, 125  		# carrega constante t6 = 125
		lui  t5, 682			# carrega constante t5 = 2796203
		addi t5, t5, 1697 		# 
		addi t5, t5, 1034 		# 	
		mul  a1, a1, t6			# a = a * 125
		rem  a1, a1, t5			# a = a % 2796203
		rem  a0, a1, a0			# a % lim
		bge  a0, zero, EH_POSITIVO  	# testa se valor eh positivo
		addi s2, zero, -1           	# caso não 
		mul  a0, a0, s2		    	# transforma em positivo
EH_POSITIVO:	
		ret				# retorna em a0 o valor obtido
############################################################################


exit:
	ret

end:
	nop