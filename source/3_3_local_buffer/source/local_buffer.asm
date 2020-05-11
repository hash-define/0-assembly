; local_buffer.asm
; Example function to demonstrate declaring local variables
; Joshua Thornton 2016

extern SreLibPrintf
extern SreLibSprintf

SECTION .data

buffer_fmt:
    db "buffer addr = 0x%08x",10,0
fmt:
    db "%s", 0

SECTION .text

global main
main:
    push ebp
    mov ebp, esp
    
    ; In C, this function might look like this:
    ; 1. void simple_echo() {
    ; 2.    char buffer[32];
    ; 3.    sprintf(buffer, "buffer addr = 0x%08x\n", &buffer);
    ; 4.    printf("%s", buffer);
    ; 5. }
    
    ; In assembly how do we declare a local variable like buffer?
    ; TASK 1: reserve space on the stack for the character buffer
    ; HINT: replace "0x00" with the correct amount
    sub esp, 0x00
    

.load_buffer_address:
    ; TASK 2: load the address of buffer into eax
    ; HINT: replace "0x00" with the correct offset
    ; HINT: if you haven't seen "lea" before it stands for "load effective address"
    lea eax, [ebp-0x00]

.call_functions:
    push eax
    push buffer_fmt
    push eax
    call SreLibSprintf
    add esp, 8
    
    push fmt
    call SreLibPrintf
    
.epilogue:

    ; Our locals and our "pushes" to other functions are automatically cleaned up here
    mov esp, ebp
    pop ebp
    ret