# Create an assembly code for MIPS32 architecture that receives an integer n
# and gives the nth fibonacci term considering:
# F(0) = 1; F(1) = 1; F(2) = 2 and so...

	.text
	.globl main

main:
	li $a0, 1
	li $s0, 1
	li $t0, 0
	li $v0, 5
	syscall

fibonacci:
	beqz $v0, print
	move $t0, $a0
	move $a0, $s0
	add $s0, $a0, $t0
	addi $v0, $v0, -1
	j fibonacci

print:
	li $v0, 1
	syscall

end:
	li $v0, 10
	syscall

