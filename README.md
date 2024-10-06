- [Introduction](#introduction)
- [x86 Architecture](#x86-architecture)
  - [Addressing Modes](#addressing-modes)
  - [x86 registers](#x86-registers)

# Introduction
In this repo I host my notes for **Programming From Ground Up** by **Jonathan Bartlett**. It has been released as an open source book and can be found here: 
https://download-mirror.savannah.gnu.org/releases/pgubook/ProgrammingGroundUp-1-0-booksize.pdf.

It also came to my attention that the author has released an updated version under a different name, so you might want to look into that.

Side notes:
1. This file will include some crucial (IMHO) points on x86 architecture for my personal reference, as well as might include other things from the book or foreign resources.
2. This book uses AT&T Assembly syntax but here and there I will include Intel (NASM) as well because it's much easier to read and there is no advantage for one over the other. I don't mark them because they are quite distinct.
3. I'm reading this book as an introduction for **The Shellcoder's Handbook: Discovering and Exploiting Security Holes** by **Chris Anley** et al. This book can be found here:
    https://www.amazon.com/Shellcoders-Handbook-Discovering-Exploiting-Security/dp/047008023X
4. There will be .s assembly code in the repo, some from the book, some might be something that I'm just testing for myself or saw elsewhere (sources should be included). 
5. A useful repo for this book can also be found here:
   https://github.com/Sivnerof/Programming-From-The-Ground-Up?tab=readme-ov-file


# x86 Architecture
Notes:
1. The order of the topics is linear with the chapters (more or less), but I don't bother numbering them.
2. In AT&T syntax % means indirect operand, and $ means immediate operand. AT&T and NASM handle memory references differently.
## Addressing Modes

* Immediate mode:

        Plainly speaking - just moving a value into the register

        mov $12, %eax
        move eax, 12

AT&T form for address reference:

        ADDRESS_OR_OFFSET(%BASE_OR_OFFSET,%INDEX,MULTIPLIER)
        FINAL ADDRESS = ADDRESS_OR_OFFSET + %BASE_OR_OFFSET + MULTIPLIER * %INDEX

* Direct addressing mode:

        This is done by only using the ADDRESS_OR_OFFSET portion
        movl ADDRESS, %eax
        Loads whatever is at ADDRESS to eax register.

* Indexed addressing mode:

        movl string_start(,%ecx,1), %eax
        Moves 1*ecx-th byte from the string_start offset.

* Indirect addressing mode:
    
        Plainly speaking - go to the address located in the register, and move data from that address.
        movl (%eax), ebx
        mov ebx, [eax]

* Base-pointer addressing mode:
    
        Plainly speaking - go to the address located in the register offset with 4 bytes, and move 4 bytes of data from that address.
        movl 4(%eax), ebx
        mov ebx, [eax+4]

## x86 registers
General purpose:
* %eax
* %ebx
* %ecx
* %edx
* %edi
* %esi

Special:
* %ebp - stack base pointer
* %esp - stack top pointer
* %eip - next instruction pointer
* %eflags - flags like zero, negative etc.

