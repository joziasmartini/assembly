.data
int_array: .word 5, 2, 8, 1, 3
array_size: .word 5
separator: .asciz ", "
end_line: .asciz "\n"

.text
main:
    # Carrega o endereço inicial do vetor em a0
    la a0, int_array

    # Carrega o tamanho do vetor em a1
    lw a1, array_size

    # Chama a função para ordenar o vetor
    jal sort_int_array

    # Imprime o vetor ordenado
    jal print_int_array

    # Termina o programa
    li a7, 10
    ecall

# Função que ordena um vetor de inteiros em ordem crescente
# Recebe o endereço inicial do vetor em a0 e o tamanho do vetor em a1
sort_int_array:
    # Implementação da função de ordenação (código já fornecido)

# Função que imprime o conteúdo de um vetor de inteiros
# Recebe o endereço inicial do vetor em a0 e o tamanho do vetor em a1
print_int_array:
    # Implementação da função para imprimir o vetor (código já fornecido)
