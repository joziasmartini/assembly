.data
string: .asciz "palindromo"
is_palindrome_msg: .asciz "A string é um palíndromo.\n"
not_palindrome_msg: .asciz "A string não é um palíndromo.\n"

.text
# Função que verifica se uma string é um palíndromo
# Recebe o endereço inicial da string em a0 e seu tamanho em a1
# Retorna uma mensagem indicando se a string é um palíndromo ou não
check_palindrome:
    # Inicializa os ponteiros para o início e fim da string
    mv t0, a0         # t0: ponteiro para o início da string
    add t1, a0, a1      # t1: ponteiro para o final da string
    addi t1, t1, -1     # Ajusta para o último caractere da string

# Loop para comparar os caracteres da primeira metade com os da segunda metade
check_loop:
    bge t0, t1, palindrome_found   # Se ponteiros se cruzaram, string é palíndromo
    lbu t2, 0(t0)                  # Carrega o caractere da primeira metade
    lbu t3, 0(t1)                  # Carrega o caractere correspondente da segunda metade
    beq t2, t3, continue_check     # Se os caracteres são iguais, continue verificação
    la a0, not_palindrome_msg      # Carrega mensagem indicando que não é palíndromo
    li a7, 4                        # Código da syscall para print string
    ecall                           # Chama a syscall para imprimir a mensagem
    ret

continue_check:
    addi t0, t0, 1      # Avança ponteiro da primeira metade
    addi t1, t1, -1     # Retrocede ponteiro da segunda metade
    jal check_loop

    # Se a execução chegar aqui, a string é um palíndromo
palindrome_found:
    la a0, is_palindrome_msg   # Carrega mensagem indicando que é palíndromo
    li a7, 4                        # Código da syscall para print string
    ecall                           # Chama a syscall para imprimir a mensagem
    ret
