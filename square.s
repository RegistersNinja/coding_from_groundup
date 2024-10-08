# as --32 square.s -o ./bin/square.a && ld -m elf_i386 ./bin/square.a -o ./bin/square

.section .data

.section .text

.globl _start
_start:
    pushl $5                  
    call square                
    addl $4, %esp              
    movl %eax, %ebx            
    movl $1, %eax             
    int $0x80                 
square:
    pushl %ebp           
    movl %esp, %ebp      
    movl 8(%ebp), %eax   
    imul %eax            
    movl %ebp, %esp      
    popl %ebp            
    ret 
    