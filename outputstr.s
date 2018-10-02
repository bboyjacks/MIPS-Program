.data
    str1:   .asciiz "Hello World!"
.text
    main:   li		$v0, 4		# $v0 = 4
    
            la		$a0, str1		# 
            syscall

            li		$v0, 10		# $v0 = 10
            syscall