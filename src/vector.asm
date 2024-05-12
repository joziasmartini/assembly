.data
array: .word 1, 2, 3, 4, 5
array_size: .word 5
separator: .asciz ", "
end_line: .asciz "\n"

.text
# Função que imprime o conteúdo de um array de inteiros
# Recebe o endereço inicial do array em a0 e o tamanho do array em a1
print_int_array:
    # Inicializa os ponteiros para o início e fim do array
    mv t0, a0          # t0: ponteiro para o início do array
    mv t1, a1          # t1: tamanho do array
    li t2, 0           # t2: índice do array

print_loop:
    # Carrega o valor do array para imprimir
    lw a0, 0(t0)       # Carrega o valor do array para imprimir
    li a7, 1           # Código da syscall para imprimir um inteiro
    ecall

    # Incrementa o ponteiro e o índice
    addi t0, t0, 4     # Avança para o próximo elemento do array
    addi t2, t2, 1     # Incrementa o índice

    # Verifica se chegou ao fim do array
    bge t2, t1, end_print  # Se o índice for maior ou igual ao tamanho, termina a impressão

    # Imprime o separador
    la a0, separator   # Carrega o endereço do separador
    li a7, 4           # Código da syscall para imprimir uma string
    ecall

    j print_loop

end_print:
    # Imprime uma nova linha
    la a0, end_line    # Carrega o endereço da nova linha
    li a7, 4           # Código da syscall para imprimir uma string
    ecall

    ret
