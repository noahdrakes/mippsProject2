.data           #data secion - location of all data in memory
out_string:     .asciiz "\nHello, 02927184\n"   # putting string in memory   
.text               #where mipps code is used
main:
    
    li $t0, 0  #clearing the $t0 register
    li $t8, 02927184 #loading bison id
    li $t9, 11 #divisor

    div $t8, $t9 #calulcation
    mfhi $t0 # n value 
loop:   
    beq	$t0, $zero, exit #check if counter = 0, exit loop if it is
    li $v0, 4       #selecting print function for syscall
    la $a0, out_string  #selecting address of string
    syscall             #print
    addi $t0, $t0, -1      #decrement counter
    j loop                  #jump back to loop
exit:
    li $v0, 10              #select exit for syscall
    syscall