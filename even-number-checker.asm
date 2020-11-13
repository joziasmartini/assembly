.globl main

    .data
vetor:  .word -5, -3, -1, 2, 4, 6
    .text
main:
    la a0, vetor #carrega o endereco do vetor
    addi a1, zero, 6 #tamanho do vetor
    add a3, zero, zero #menor indice = 0
    jal quantity #pula para quantity
quantity:
    addi  t0, zero, 1 #inicializa contador
    lw t1, 0 (a0) #le posicao 0 do vetor (menor)
    add t1, t1, 1 #faz adicao com constante, se 1 impar, se 0 par
    beq t1, 0, pair #se t1 e zero forem iguais, pula para par
    jal end #se nao, termina
pair:
    add t0, zero, 1 #acrescenta contador se for par
    jal quantity #pula verificar os outros numeros
end:
    add a0, zero, t0 #quantidade de elementos no vetor
