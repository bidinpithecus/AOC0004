# Faça um programa em Assembly para MIPS que:
#     Leia um inteiro n da entrada padrão
#         n é um inteiro positivo de 32 bits em complemento 2
#     Seu programa deve tratar uma entrada composta por vários casos de testes e parar quando: n == 0
#     Implemente uma função recursiva que calcule a soma dos dígitos decimais de n
#     Imprima uma linha com o resultado retornado pela função na saída padrão em decimal
#     A função recursiva deve fazer apenas o cálculo (salvando e restaurando o contexto como apropriado)
#     A função principal (main) deve fazer toda a parte de entrada e saída
#     Respeite a convenção dos registradores para receber e retornar valores de função

.data
	newLine: .ascii "\n"
.text
.globl main

main:
	while:
	li $v0, 5
	syscall

	move $a0, $v0

	beq $a0, $zero, end

	jal sumDigit

	move $a0, $v0
	li $v0, 1
	syscall

	li $v0, 4
	la $a0, newLine
	syscall

	j while

end:
	li $v0, 10
	syscall

sumDigit:
	# Salvar variáveis na pilha:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $s0, 8($sp)

	# Função:
	li $v0, 0
	li $t0, 10
	div $a0, $t0
	# $a0 = quociente
	mflo $a0
	# $s0 = resto
	mfhi $s0
	# Se o quociente da divisão for 0 não continua a recursão
	beq $a0, $zero, endSumDigit
	jal sumDigit
	endSumDigit:
	# Se o resto da divisão for igual à k, soma 1 no contador (retorno)
	add $v0, $v0, $s0

	# Restaurar variáveis:
	lw $s0, 8($sp)
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	jr $ra
