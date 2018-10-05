# Lester Dela Cruz
# CDA3101
# programming_assignment_1.s
# Description:
#   This program waits for input of integer, operation, and integer
#   then evaluates the entered statement and prints them

.data

int_str:                    .asciiz "int: "
op_str:                     .asciiz "op: "
goodbye_message:            .asciiz "Goodbye"
overflow_message:           .asciiz "Overflow, state reset to 0.\n"
dividing_by_zero_message:   .asciiz "Attempting to divide by zero. Please enter a new divisor.\n"
input_op:                   .space 4
end_line:                   .asciiz "\n"

.text

main:
    # $t0 -> Answer
    # $t1 -> first value
    # $t2 -> second value
    # $t3 -> operator address
    # $t4 -> operator char
    # $t5 -> lo register
    # $t6 -> hi register

    li		$v0, 4		        # code to print 'int: '
    la		$a0, int_str
    syscall

    li		$v0, 5		        # read user integer input
    syscall

    move 	$t1, $v0		    # move the read integer to $t1
    
    j get_operator

get_operator:

    li		$v0, 4		        # code to print 'op: '
    la      $a0, op_str
    syscall

    li      $v0, 8              # code to read operation string
    la		$a0, input_op		# save it in memory
    li      $a1, 4
    syscall

    la      $t3, input_op       # load user input address to $t3
    lb		$t4, 0($t3)		    # get first byte of input_op

    beq		$t4, 'e', end_program	# if $t4 == 'e' then end_program
    j get_second_input

get_second_input:
    li      $v0, 4              # print 'int: ' again
    la      $a0, int_str
    syscall

    li      $v0, 5              # code to read second input int
    syscall

    move    $t2, $v0            # move the second value to $t2
    j evaluate

evaluate:

    beq     $t4, '+', plus      # if operator is '+' then add $t1 and $t2 and store in $t0
    beq		$t4, '-', minus	# if $t4 == '-' then target
    beq     $t4, '*', multiply
    beq     $t4, '/', divide
    

eval_cont:

    li      $v0, 1              # code to print evaluation result
    move    $a0, $t0
    syscall

    move    $t1, $t0            # make the result the new $t1

    li      $v0, 4              # print end line
    la      $a0, end_line
    syscall

    j get_operator

plus:

    add     $t0, $t1, $t2       # add first and second value and store in $t0
    j eval_cont

minus:
    sub		$t0, $t1, $t2		# subtract the first from second value and store in $t0
    j eval_cont

multiply:
    mult	$t1, $t2		    # multiply first value with second
    mflo	$t5					# copy Lo to $t5
    mfhi    $t6
    beq     $t6, $zero, not_overflow
    j multiply_overflow

divide:
    beq     $t2, $zero, dividing_by_zero
    div     $t1, $t2            # divide the first with the second
    mflo    $t5
    move    $t0, $t5

    j eval_cont

dividing_by_zero:

    li      $v0, 4              # print dividing by zero error
    la      $a0, dividing_by_zero_message
    syscall

    j get_second_input
    
not_overflow:
    move    $t0, $t5
    j eval_cont

multiply_overflow:
    move    $t0, $zero          # reset answer and print overflow error message
    li      $v0, 4
    la      $a0, overflow_message
    syscall

    j eval_cont

end_program:

    # Write the Goodbye message and end program
    li		$v0, 4      		# code to print Goodbye message
    la      $a0, goodbye_message
    syscall
    
    li $v0, 10                  # end program
    syscall
    
    
    
    
    
    