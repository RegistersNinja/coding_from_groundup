# as --32 exit.s -o ./bin/exit.a && ld -m elf_i386 ./bin/exit.a -o ./bin/exit && rm ./bin/exit.a

.section .data

.section .text

.globl _start

_start:
mov $1, %eax
mov $10, %ebx
int $0x80



