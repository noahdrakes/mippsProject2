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

    #register for sum 
    li $t4, 0

    #change s3 to t6
    

    loop:
        #value for storing decimal value of each character
        li $t5, 0

        #value for storing single byte
        li $t6, 0

        #checking if loop is finished
        beq $t0, $t1, print

        lb $t6, 0($t7) #load first byte into register $t6

        ble $t6, 57, decimal
        ble $t6, $t2, capitalLetters
        ble $t6, $t3, lowercaseLetters
        ble $t6, 127, nothingHappens

        decimal:
            blt $t6, 48, nothingHappens
            addi $t5, $t6, -48
            add $t4, $t4, $t5
            j nothingHappens

        capitalLetters:
            blt $t6, 65, nothingHappens
            addi $t5, $t6, -55
            add $t4, $t4, $t5
            j nothingHappens

        lowercaseLetters:
            blt $t6, 97, nothingHappens
            addi $t5, $t6, -87
            add $t4, $t4, $t5
            j nothingHappens

        nothingHappens:
            #nothing happens

        addi $t0, $t0, 1 #incriment
        addi $t7, $t7, 1
    
        j loop