.data   #data secion - location of all data in memory
    userInput: .space 12
    newLineCharacter: .asciiz "\n"


.text               #where mipps code is used




main:

    li $t8, 02927184 #loading bison id
    li $t9, 11 #divisor

    div $t8, $t9 #calulcation
    mfhi $t0 # n value 
    addi $s0, $t0, 26 #N is in $s0 add 26 to modulus
    addi $s1, $s0, -10 #M is in $s1

    li $v0, 8 #get input from user
    la $a0, userInput #read 11 characters
    li $a1, 11
    syscall #execute previous instruction 

#s0 = N
    #S1 = M
    #t7 = userInput (11 bytes)
    #t6 = single character (1 byte)

    li $t0, 0
    li $t1, 11
    move $t7, $a0

    #range for CAPITAL LETTERS 
    addi $t2, $s1, 65

    #range for LOWERCASE LETTERS
    addi $t3, $s1, 97