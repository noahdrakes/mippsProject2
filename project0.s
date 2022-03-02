.data           #data secion - location of all data in memory
out_string:     .asciiz "\nHello, 02927184\n"   # putting string in memory   
.text               #where mipps code is used
main:
    
    li $t0, 0  #clearing the $t0 register   
