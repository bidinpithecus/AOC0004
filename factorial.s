# Write an assembly code for MIPS32 architecture that receives an integer n and outputs n!
# Assume n is bigger than 1 and lower than 10
	.text
	.globl main

main:
	# Accumulator, already in register $a0 to save a register
	li $a0, 1
	# With 5 in register $v0, syscall will input an integer
	li $v0, 5
	syscall

factorial:
	mult $a0, $v0
	mflo $a0
	addi $v0, $v0, -1
	bnez $v0, factorial

print:
	# With 1 in register $v0, syscall will output the integer stored in $a0
	# Since we are already writing on it, we don't have to move the value wanted to $a0
	li $v0, 1
	syscall

end:
	li $v0, 10
	syscall

