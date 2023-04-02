.data
	newLine: .asciiz "\n"

.text
.globl main
main:
	li $v0, 5
	syscall
	move $a0, $v0

	jal fib

	move $a0, $v0
	li $v0, 1
	syscall

	la $a0, newLine
	li $v0, 4
	syscall

	li $v0, 10
	syscall

fib:
	# Save context
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)

	move $s0, $a0

	li $t1, 1
	beq $s0, $zero, return
	beq $s0, $t1, return

	addi $a0, $s0, -1
	# Call fib recursively with $a0 as argument. fib(n - 1)
	jal fib

	# Move the return value of the first fib call to $s1.
	move $s1, $v0
	# Subtract 2 from $s0 and move the result to $a0.
	addi $a0, $s0, -2
	# Call fib recursively with $a0 as argument. fib(n - 2)
	jal fib

	# Add the two return values of the fib calls and store the result in $v0. fib(n - 1) + fib(n - 2)
	add $v0, $v0, $s1

restoreContext:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12

	jr $ra

return:
	li $v0, 1
	j restoreContext
