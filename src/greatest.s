	.text
	.globl main

main:
	li $v0, 5
	syscall
	move $a0, $v0
	li $v0, 5
	syscall
	move $a1, $v0
	jal greater
	move $a0, $v0
	li $v0, 1
	syscall

end:
	li $v0, 10
	syscall

greater:
	# If $a0 > $a1, $t0 = 1
	sgt $t0, $a0, $a1
	beq $t0, 1, a0
	move $v0, $a1
	jr $ra

a0:
	move $v0, $a0
	jr $ra
