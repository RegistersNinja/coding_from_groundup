# as --32 factorial.s -o ./bin/factorial.a && ld -m elf_i386 ./bin/factorial.a -o ./bin/factorial && rm ./bin/factorial.a

.section .data
.section .text
.globl _start

_start:
pushl $4
call factorial
addl $4, %esp
movl %eax, %ebx
movl $1, %eax

int $0x80
# move the current stack number to eax
# compare it to one, and return
# or: decrease 1, push to the stack and call again for factorial

factorial:
push %ebp
movl %esp, %ebp
movl 8(%ebp), %eax

cmpl $1, %eax
jz end_factorial

decl %eax
push %eax
call factorial
movl 8(%ebp), %ebx
imull %ebx, %eax

end_factorial:
movl %ebp, %esp
pop %ebp
ret
