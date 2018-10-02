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

    li $v0, 10                  # end program
    syscall
    
