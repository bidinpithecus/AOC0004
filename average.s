# Create an assembly code for MIPS32 architecture that receives n integers and outputs the sum of the n terms and the average (the hole part of it) of them
# to stop inputing, -1 should be read. In case no numbers are inputed (only -1), must output an error message (ERRO) in the average section of answer.
# sum and average should be separated by a new line (\n)

	.data

newLine:
	.asciiz "\n"

errorMessage:
	.asciiz "ERRO"

	.text
	.globl main

main:
	# Sum of the terms
	li $s0, 0
	# Number of terms
	li $s1, 0
	# Comparison
	li $s2, -1

input:
	# input int code for syscall	
	li $v0, 5
	syscall
	beq $v0, $s2, printSum
	add $s0, $s0, $v0
	addi $s1, $s1, 1
	j input

printSum:
	# moving to $a0 the sum of numbers stored in $s0
	move $a0, $s0
	# output int code for syscall
	li $v0, 1
	syscall
	# to output a string we must:
	# load address to $a0 of what is wanted to be printed
	la $a0, newLine
	# load imediate 4 to $v0, which is the syscall code for printing a string
	li $v0, 4
	syscall

avg:
	# checking if number of terms is zero, to print either the error message or not
	beqz $s1, error
	div $a0, $s0, $s1
	li $v0, 1
	syscall
	j end

error:
	la $a0, errorMessage
	li $v0, 4
	syscall

end:
	li $v0, 10
	syscall

