- [Introduction](#introduction)
- [x86 Architecture](#x86-architecture)
  - [Addressing Modes](#addressing-modes)
  - [x86 registers](#x86-registers)
  - [Basic operations](#basic-operations)
  - [Functions, the stack, calling conventions](#functions-the-stack-calling-conventions)
    - [Functions](#functions)

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
        FINAL_ADDRESS = ADDRESS_OR_OFFSET + %BASE_OR_OFFSET + MULTIPLIER * %INDEX

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
* %eax - return value
* %ebx - exit status code
* %ecx
* %edx
* %edi
* %esi

Special:
* %ebp - stack base pointer
* %esp - stack top pointer
* %eip - next instruction pointer
* %eflags - flags like zero, negative etc.

## Basic operations
A good quick reference for x86_32 can be found here:
https://flint.cs.yale.edu/cs421/papers/x86-asm/asm.html

Here is the quickest primer:
1. mov - moves value from one place to another
2. inc,dec - subtracts/adds 1 to a specified place
3. mull - multiplies 2 numbers
4. push/pop - pushes/pop value onto/from stack
5. jmp, j[condition] - jmp unconditionally jumps to a specified label, whereas adding a condition jumps based on eflags registry. Condition suffix can be: e =, ne !=, z 0, g >, ge >=, l <, le <=.

Assembly loop:

        <label_start_loop>:
        cmp <stop condition>, <iterator register, usually %ecx>
        je <label_end_loop>
        {loop body}
        jmp <label_start_loop>

        <label_end_loop>

## Functions, the stack, calling conventions
Resources: 
There are many good ones', I will list here the ones' I would revisit if I needed a refresher.
1. A great channel, and especially great introduction to this topic (probably covers the entire section and possibly more) - https://www.youtube.com/watch?v=ZXoW5iqbFJE.
2. To debug an assembly program I use x86dbg if I have to (unfortunately) use Windows, or edb for linux that can be found here:
https://github.com/eteran/edb-debugger. These programs are great for **stack and register visualization** and should be used often.
3. Calling conventions - the idea is that when function/program is finished executing, someone has to cleanup the stack (i.e return it to it's previous state). A popular convention used by **gcc** is **cdecl** by which a caller is always responsible for the stack. See here:
https://en.wikipedia.org/wiki/X86_calling_conventions

### Functions
Function definition can be as simple as

        <label>:
        {function body}

To invoke a function simply use **call** <label>. Note: **call** pushes return address onto the stack, where as **jmp** (and its' siblings) doesn't. Essentially other than that, they do the same thing.

To properly utilize functions you have to set up the stack in the beginning with essential operations.

        push %ebp
        mov %esp, %ebp

This sets up the stack such that it's easy to distinguish between different stack frames (for example the caller and the current functions). So it looks like this:

        [Caller Stack Frame]
        [Return Address]
        [Old Base Pointer] <--- %esp, %ebp
And now you can easily reference pushed value onto the stack with the current base pointer (they would start at 4(%ebp)). 

When your function is done, you should remove any values from the stack, restore the stack pointer, pop the old base pointer into %ebp, and return (ret).

Note the return and exit registers [here](#x86-registers).
