# Lester Dela Cruz
# CDA3101
# programming_assignment_1.s
# Description:
#   This program waits for input of integer, operation, and integer
#   then evaluates the entered statement and prints them
.data

int_str: .asciiz "int: "    # store the 'int: ' string
op_str: .asciiz "op: "      # store the 'op: ' string

.text
.globl main

main:
    li		$v0, 4		        # $v0 = 4 : code to print 'int: '
    la		$a0, int_str
    syscall

    li		$v0, 5		        # $v0 = 5 : code to read integer
    syscall    
    
    move 	$t0, $v0		    # $t0 = $v0 : move the value read into $t0
    li		$v0, 1		        # $v0 = 1   : code to print integer
    move 	$a0, $t0		    # $a0 = $t0 : move the value in $t0 to $a0 to be printed
    syscall

    li $v0, 10                  # end program
    syscall