# as --32 maximum.s -o ./bin/maximum.a && ld -m elf_i386 ./bin/maximum.a -o ./bin/maximum && rm ./bin/maximum.a


# %edi - the iterator
# %ebx - the current max
# %eax - current data item

.section .data
data_items:
.long 1,500,34,222,45,75,54,34,44,33,22,11,66,0

.section .text
.globl _start

_start:
movl $0, %edi
movl data_items(,%edi,4), %eax
movl %eax, %ebx

start_loop:
cmpl $0, %eax
je loop_exit

incl %edi
movl data_items(,%edi,4), %eax
cmpl %ebx, %eax
jle start_loop

movl %eax, %ebx
jmp start_loop

loop_exit:
movl $1, %eax
; int $0x80
