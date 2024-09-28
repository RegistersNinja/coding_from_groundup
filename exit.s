.section .data

.section .text

.globl _start

_start:
mov $1, %eax
mov $10, %ebx
int $0x80



