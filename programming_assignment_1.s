# Lester Dela Cruz
# CDA3101
# programming_assignment_1.s
# Description:
#   This program waits for input of integer, operation, and integer
#   then evaluates the entered statement and prints them
.data

int_str: .asciiz "int: "    # store the 'int: ' string
op_str: .asciiz "op: "      # store the 'op: ' string
goodbye_message: .asciiz "Goodbye"
input_op: .space 4

.text
.globl main

main:
    # $t0 -> Answer
    # $t1 -> first value
    # $t2 -> second value
    # $t3 -> operator address
    # $t4 -> operator char
start_program:
    li		$v0, 4		        # $v0 = 4 : code to print 'int: '
    la		$a0, int_str
    syscall

    li		$v0, 5		        # $v0 = 5 : code to read integer
    syscall    
    
    move 	$t1, $v0		    # $t0 = $v0 : move the value read into $t0

    li		$v0, 4		        # $v0 = 4 : code to print 'op: '
    la		$a0, op_str
    syscall

    li		$v0, 8 		        # $v0 = 8 : code to read char
    la      $a0, input_op
    li      $a1, 4
    syscall

    la		$t3, input_op		# 
    lb		$t4, 0($t3)		    # 

    beq		$t4, '+', plus	        # if $t1 == '+' plus
    beq		$t4, 'e', end_program	# if $t4 == 'e' then end_progrm
    

print_result:
    li		$v0, 1		        # $v0 = 1
    move 	$a0, $t0		    # $a0 = $t3 : move $t3 to $a0 to be printed
    syscall
    j start_program

end_program:
    # Write the Goodbye message and end program
    li		$v0, 4      		# $v0 = 4
    la      $a0, goodbye_message
    syscall
    
    li $v0, 10                  # end program
    syscall

plus:
    add		$t0, $t1, $t2		# $t3 = $t0 + $t2
    j print_result
    