.data
a: .word 5
b: .word 7
c: .word 6
triangle_msg: .asciz "Os valores formam um triângulo.\n"
not_triangle_msg: .asciz "Os valores não formam um triângulo.\n"

.text
# Função que verifica se os valores formam um triângulo
# Recebe os valores em a0, a1 e a2 e retorna 1 se formam um triângulo, 0 caso contrário
check_triangle:
    # Verifica se A é o maior valor
    bge a0, a1, check_b_c
    bge a0, a2, check_b_c

    # A é o maior valor
    add t0, a1, a2      # Soma B e C
    blt a0, t0, is_triangle  # Se A < B+C, forma um triângulo
    li a0, 0            # Caso contrário, não forma um triângulo
    ret

check_b_c:
    # Verifica se B é o maior valor
    bge a1, a2, check_a_c
    bge a1, a0, check_a_c

    # B é o maior valor
    add t0, a0, a2      # Soma A e C
    blt a1, t0, is_triangle  # Se B < A+C, forma um triângulo
    li a0, 0            # Caso contrário, não forma um triângulo
    ret

check_a_c:
    # C é o maior valor
    add t0, a0, a1      # Soma A e B
    blt a2, t0, is_triangle  # Se C < A+B, forma um triângulo
    li a0, 0            # Caso contrário, não forma um triângulo
    ret

# Função para sair
exit_program:
    li a7, 10
    ecall

# Função auxiliar para imprimir a mensagem
print_message:
    li a7, 4            # Código da syscall para print string
    ecall
    j exit_program

# Função para imprimir a mensagem de triângulo
is_triangle:
    la a0, triangle_msg # Carrega o endereço da mensagem
    j print_message

# Função para imprimir a mensagem de não triângulo
not_triangle:
    la a0, not_triangle_msg # Carrega o endereço da mensagem
    j print_message

# Função principal
main:
    # Carrega os endereços de memória dos valores dos lados do triângulo
    la t0, a
    la t1, b
    la t2, c

    # Carrega os valores dos lados do triângulo
    lw a0, 0(t0)
    lw a1, 0(t1)
    lw a2, 0(t2)

    # Chama a função para verificar se forma um triângulo
    jal ra, check_triangle

    # Verifica o resultado
    beqz a0, not_triangle
    # Saída indicando que os valores formam um triângulo
    j is_triangle
