.data   
    userInput: .space 1000
    newLineCharacter: .asciiz "/n"
    array4characters: .byte 0,0,0,0 
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

    li $v0, 8               #get input from user
    la $a0, userInput       #read 1000 characters
    li $a1, 999             #set amount of characters (bytes)
    syscall                 #execute previous instruction 

    move $t7, $a0           #move userInput value to an accessible register
    
    li $t6, 0               #register for new string value without extra spaces
    
    #value for storing single byte
    li $t6, 0

    

    #                       **REMOVING BEGINNING SPACES AND TABS **

    li $t5, 0 #increment for removeSpaces and Tabs

    removeSpacesAndTabs:
        beq $t5, 1000, storeRealValues  #check if reached end of input
        lb $t6, 0($t7)      #load single byte into register $t6


        #       checks if there are any spaces

        beq $t6, 11, skip   #if character is line tab -> skip
        beq $t6, 9, skip    #if character is char tab -> skip
        beq $t6, 32, skip   #if character is space    -> skip

        move $t4, $t7         #save the increment where the first character starts [$t4]

        j storeRealValues   #once first real value is detected jump to store real values 

        skip:

        addi $t5, $t5, 1 #increment loop index
        addi $t7, $t7, 1 #increment index for array of user input characters
        j removeSpacesAndTabs


    
    #                       **STORE THE FIRST FOUR LEGITIMATE VALUES**
    
    #using register $t3 for array

    li $t5, 0               #increment for store real values
    
    storeRealValues:    
        beq $t5, 3, checkRemainingTrailingCharacters        #check if increment is less than 4
        sb $t6, 0($t3)

        addi $t5, $t5, 1
        addi $t3, $t3, 1
        j storeRealValues


    checkRemainingTrailingCharacters:

li $v0, 10              #select exit for syscall
syscall
