# Faça um programa em Assembly para MIPS que:
#   Leia dois inteiros n e k da entrada padrão, respectivamente. Um em cada linha.
#        n é um inteiro positivo de 32 bits em complemento 2
#        0 <= k <= 9
#    Seu programa deve tratar uma entrada composta por vários casos de testes e parar quando: n == 0 (sem ler o respectivo k)
#    Implemente uma função recursiva que determine quantas vezes O dígito K ocorre em um número natural N
#    Imprima uma linha com o resultado retornado pela função na saída padrão
#    A função recursiva deve fazer apenas o cálculo (salvando e restaurando o contexto como apropriado)
#    A função principal (main) deve fazer toda a parte de entrada e saída
#    Respeite a convenção dos registradores para receber e retornar valores de função
#	 Contador de ocorrências de um dígito k em um número n

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

	li $v0, 5
	syscall

	move $a1, $v0

	jal digitCount

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

digitCount:
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
	# (1) Se o quociente da divisão for 0 não continua a recursão
	beq $a0, $zero, verifyRest
	jal digitCount
	verifyRest:
	# (2) Se o resto da divisão for igual à k, soma 1 no contador (retorno)
	bne $s0, $a1, endDigitCount
	addi $v0, $v0, 1

	# Restaurar variáveis:
	endDigitCount:
	lw $s0, 8($sp)
	lw $a0, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	jr $ra
