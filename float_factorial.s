.text
.globl __start

__start:
li $v0, 6
syscall
cvt.w.s $f0, $f0
cvt.s.w $f0, $f0
jal Fac
mtc1 $v0, $f12
li $v0, 2
syscall
jal print_endl1
li $v0, 10
syscall

Fac:
addi $sp, $sp, -4
s.s  $f1, 0($sp)
lwc1 $f1, one
cvt.s.w $f1, $f1 
c.le.s $f1, $f0
bc1t calc
j end
calc:
addi $sp, $sp, -8
s.s  $f0, 4($sp)
sw $ra, 0($sp)
sub.s $f0, $f0, $f1  
jal Fac
l.s $f0, 4($sp)
lw $ra, 0($sp)
mtc1 $v0, $f1
addi $sp, $sp, 8
mul.s $f1, $f1, $f0
end:
mfc1 $v0, $f1
l.s $f1, 0($sp)
addi $sp, $sp, 4
jr $ra
.text 
print_endl1:		la		$a0,endl 			# system call to print
					li		$v0, 4 				# out a newline
					syscall
					jr $ra

.data
one: .word 1
endl: .asciiz "\n"