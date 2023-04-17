	.text
	.globl main

main:
	li $v0, 5
	syscall
	move $a0, $v0
	jal sum
	move $a0, $v0
	li $v0, 1
	syscall

end:
	li $v0, 10
	syscall

sum:
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a0, 4($sp)

	beqz $a0, endSum
	addi $a0, $a0, -1
	move $v0, $a0

	jal sum

	lw $ra, 0($sp)
	lw $a0, 4($sp)
	addi $sp, $sp, 8

	add $v0, $v0, $a0
	jr $ra

endSum:
	li $v0, 0
	jr $ra
