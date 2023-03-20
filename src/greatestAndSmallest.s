	.text
	.globl main
main:
	li $v0, 5
	syscall
	move $a0, $v0
	li $v0, 5
	syscall
	move $a1, $v0
	li $v0, 5
	syscall
	move $a2, $v0
	jal greaterAndLesser

end:
	li $v0, 10
	syscall

greaterAndLesser:
	slt $t0, $a0, $a1
	slt $t1, $a0, $a2
	
