.data   
    userInput: .space 1000
    newLineCharacter: .asciiz "/n"
.text

main:

    #  ****occupied registers****
    #   $s0 = M
    #   $s1 = N
    #   $t7 = characters from user input
    #   #t6 = new register for update user input without unnecessary spaces

    li $t8, 02927184 #loading bison id
    li $t9, 11 #divisor

    div $t8, $t9 #calulcation
    mfhi $t0 # n value 
    
    addi $s0, $t0, 26 #N is in $s0 add 26 to modulus
    addi $s1, $s0, -10 #M is in $s1

    #M = $s0
    #N = $s1

    li $v0, 8 #get input from user
    la $a0, userInput #read 1000 characters
    li $a1, 999 #set amount of characters (bytes)
    syscall #execute previous instruction 

    move $t7, $a0 #move this value to an accessible register
    
    li $t6, 0 #register for new string value without extra spaces
    

    li $t5, 0 #increment for removeSpaces and Tabs
    removeSpacesAndTabs:
        beq $t5, 1000, calculateValueFromInput #check if reached end of input


        j removeSpacesAndTabs


    
    


li $v0, 10              #select exit for syscall
syscall