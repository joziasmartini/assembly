.globl main

    .text
main:
    addi a0, zero, 7
    addi a1, zero, 4
    addi a2, zero, 1
    addi a3, zero, 0
    jal multiply
multiply:
    blt a0, a1, end
    add a3, a0, a3
    add a2, a2, 1
end:
    add a0, zero, a3
