.data   
    userInput: .space 1000
    newLineCharacter: .asciiz "\n"
    array4characters: .space 4
    invalidInputString: .asciiz "Not Recognized \n"
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


        j storeRealValues   #once first real value is detected jump to store real values 

        skip:

        addi $t5, $t5, 1 #increment loop index
        addi $t7, $t7, 1 #increment index for array of user input characters
        j removeSpacesAndTabs


    
    #                       **STORE THE FIRST FOUR LEGITIMATE VALUES**
    


    #using register $t3 for array

    
    storeRealValues:  
        li $t4, 0                   #increment for store real values
        li $t3, 0                   #load address to store array of 4 bytes for the 4 real characters

        loopStoreRealValues:  
            beq $t4, 4, checkRemainingTrailingCharacters        #check if increment is less than 4
            sb $t6, array4characters($t3)                       #store valid characters in new array                   

            #       if it sees a space, it jumps to trailing characters

            beq $t6, 11, checkRemainingTrailingCharacters   #if character is line tab -> checkRemainingCharacters
            beq $t6, 9, checkRemainingTrailingCharacters    #if character is char tab -> checkRemainingCharacters
            beq $t6, 32, checkRemainingTrailingCharacters   #if character is space    -> checkRemainingCharacters
            
            addi $t4, $t4, 1        #increment loop
            addi $t7, $t7, 1        #increment index for array of user input characters
            addi $t3, $t3, 1        #increment index for character array
            addi $t5, $t5, 1        #increment original character loop to skip the valid character and check for invalid characters in the check trailing remain characters function
            lb $t6, 0($t7)          #get next character from four bit array


             
            j loopStoreRealValues


    checkRemainingTrailingCharacters:
       beq $t5, 1000, check4CharactersArray #loop condition -> once program has reached the 1000th character

        beq $t6, 10, check4CharactersArray   #if character is new line character character -> end of string, determine if its valid
        beq $t6, 0, check4CharactersArray   #if character is null terminating character -> end of string, determine if its valid

        beq $t6, 11, skip1   #if character is line tab -> skip
        beq $t6, 9, skip1    #if character is char tab -> skip
        beq $t6, 32, skip1   #if character is space    -> skip

        j invalidInput

        skip1: 
            addi $t7, $t7, 1
            lb $t6, 0($t7)          #get next character from four bit array

            j checkRemainingTrailingCharacters



invalidInput:
    li $v0, 4       #selecting print function for syscall
    la $a0, invalidInputString  #selecting address of string
    syscall
    j exitProgram




check4CharactersArray:
    li $t5, 0          #index of loop

    li $t7, 3           #index of 4character array

    li $t2, 0           #reg for storing the correct decimal value for characters

    #range for CAPITAL LETTERS 
    addi $t2, $s1, 65

    #range for LOWERCASE LETTERS
    addi $t3, $s1, 97

    #register for sum 
    li $t4, 0

    loop2:
        beq $t5, 4, printAnswer     #once loop ends print answer
        lb $t6, array4characters($t7)       #get character from (potentially) valid character away

        beq $t6, 11, invalidInput   #if character is line tab -> jump to invalid Input
        beq $t6, 9, invalidInput    #if character is char tab -> jump to invalid input
        beq $t6, 32, invalidInput   #if character is space    -> jump to invalid input

        li $t1, 1           #reg for carrying exponent

        exponentLoop:
            beq $t5, 0, exponent0
            beq $t5, 1, exponent1
            beq $t5, 2, exponent2
            beq $t5, 3, exponent3





            exponent0:
                mult 1, $t2
                mflo $t2
            exponent1:
                mult $s1, $t2
                mflo $t2
         





        addi $t5, $t5, 1
        addi $t7, $t7, -1
        j loop2

printAnswer:


exitProgram:
    li $v0, 10              #select exit for syscall
    syscall



# lb $t1, array4characters($t3)
            # li $v0, 1       #selecting print function for syscall
            # move $a0, $t1  #selecting address of string
            # syscall

            # li $v0, 4       #selecting print function for syscall
            # la $a0, newLineCharacter  #selecting address of string
            # syscall