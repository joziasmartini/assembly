.data
input_string: .space 100    # Espaço para armazenar a string de entrada
output_string: .space 100   # Espaço para armazenar a string de saída
prompt_msg: .asciz "Digite uma string: "
vowels: .asciz "aeiouAEIOU"
end_line: .asciz "\n"

.text
main:
    # Exibe uma mensagem para solicitar a entrada do usuário
    la a0, prompt_msg
    li a7, 4           # Código da syscall para imprimir uma string
    ecall

    # Lê uma string do teclado
    la a0, input_string
    li a1, 100          # Tamanho máximo da string
    li a7, 8            # Código da syscall para ler uma string
    ecall

    # Chama a função para remover as vogais da string
    la a0, input_string
    la a1, output_string
    jal remove_vowels

    # Imprime a string resultante
    la a0, output_string
    li a7, 4            # Código da syscall para imprimir uma string
    ecall

    # Termina o programa
    li a7, 10           # Código da syscall para sair
    ecall

# Função que remove todas as vogais de uma string
# Recebe o endereço inicial da string de entrada em a0 e o endereço inicial da string de saída em a1
remove_vowels:
    # Inicializa os ponteiros para as strings de entrada e saída
    mv t0, a0          # t0: ponteiro para a string de entrada
    mv t1, a1          # t1: ponteiro para a string de saída

remove_loop:
    lbu t2, 0(t0)      # Carrega o próximo caractere da string de entrada
    beqz t2, end_remove_vowels   # Se chegou ao final da string, termina o loop

    # Verifica se o caractere é uma vogal
    la t3, vowels      # Carrega o endereço das vogais
    li t4, 0           # Inicializa o índice do caractere vogal
check_vowel:
    lbu t5, 0(t3)      # Carrega o próximo caractere vogal
    beqz t5, not_vowel_found   # Se chegou ao final da lista de vogais, não é uma vogal
    beq t2, t5, is_vowel       # Se encontrou uma vogal, remove o caractere
    addi t3, t3, 1     # Avança para o próximo caractere vogal
    j check_vowel

is_vowel:
    addi t0, t0, 1     # Avança para o próximo caractere da string de entrada
    j remove_loop

not_vowel_found:
    sb t2, 0(t1)       # Copia o caractere para a string de saída
    addi t0, t0, 1     # Avança para o próximo caractere da string de entrada
    addi t1, t1, 1     # Avança para o próximo caractere da string de saída
    j remove_loop

end_remove_vowels:
    sb zero, 0(t1)     # Adiciona o caractere nulo de término de string na string de saída
    ret
