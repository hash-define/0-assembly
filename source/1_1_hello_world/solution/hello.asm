; hello.asm
; Hello, World! example program
; Joshua Thornton 2015

extern SreLibPrintf        ; external import

EXIT_SUCCESS equ 0          ; this is a constant
                            ; this does not end up in the resulting program
                            ; the pre-processor finds each occurrance and
                            ; replaces it with its value
                            ; you should avoid having constants throughout
                            ; your program by using pre-processor definitions
                            ; like this one

SECTION .data               ; Data section, for intialized variables

hello:                      ; label for data section item
    db "Hello, World!",10,0 ; "db" indicates that we want to store bytes (8-bit)
                            ; "dw" would be used for words (16-bit)
                            ; "dd" for double words (32-bit)
                            ; "dq" for quad words (64-bit)
                            ; I don't know how to do "\n\0" characters so I had
                            ; to use the literals values: 10,0
a:
    dw 0x1234               ; for example this will take up 2 bytes of space

fmt:
    db "My name is: %s",10,0

name:
    db "Student",0
    
length:
    db "Length of '%s' is %d",10,0

SECTION .text               ; Text section, for executable code

global main                ; standard entry point
main:

    push ebp                ; standard function prologue to setup stack frame
    mov ebp, esp            ; we will examine this later


    ; beginning of our "Hello, World!" call
    push dword hello        ; intel syntax requires you specify operand size
                            ; "byte":   8 bits
                            ; "word":   16 bits
                            ; "dword":  32 bits
                            ; "qword":  64 bits
                            ; here we are pushing a 32-bit pointer to the stack
                            ; "fmt" is the label for the location of our string
    call SreLibPrintf      ; call the function
    add esp, 4              ; we pushed 4 bytes onto the stack, we need to
                            ; "clean up" the stack frame after the function
                            ; we will discuss later other techniques to 
                            ; accomplish this
    ; end hello world call
    
    push dword name
    push dword fmt
    call SreLibPrintf
    add esp, 8
    
    push dword name
    call strlen
    add esp, 4
    
    push eax
    push dword name
    push dword length
    call SreLibPrintf
    add esp, 12 

    mov eax, EXIT_SUCCESS   ; by convention eax holds the return value
                            ; we will discuss this more later
    
    mov esp, ebp            ; standard function epilogue
    pop ebp
    ret                     ; return

; This is an additonal function to determine a string's length
; It will form part of an extension exercise, ignore it for now
; This will also be used to explain pointers if necessary
global strlen
strlen:
    push ebp
    mov ebp, esp
    ; state of the stack in this function
    ; -0x08 argument 0
    ; -0x04 ret address
    ;  0x00 ebp

    ; we will store the length of the string in eax
    mov dword eax, 0

    ; we need to get the character pointer from the passed in arguments
    mov dword ecx, [ebp+0x08]

.loop:
    
    ; dereference pointer + offset
    ; compare to null terminator character
    ; exit if found
    cmp byte [ecx+eax], 0
    je .null_found

    ; not found -> increment offset and loop
    inc eax
    jmp .loop

.null_found:
    mov esp, ebp
    pop ebp
    ret
