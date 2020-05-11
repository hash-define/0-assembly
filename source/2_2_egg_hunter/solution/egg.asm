; egg.asm
; Egg Hunter example program
; Joshua Thornton 2015

; Imports
extern SreLibPrepareEgg

; Constants
EXIT_SUCCESS    equ 0      
EXIT_FAILURE    equ 1
EGG             equ 0xCAFEBABE
EGG_SIZE        equ 4
XOR_VALUE       equ 0x12
BUFFER_SIZE     equ 0x100

SECTION .data               ; Data section, for intialized variables
shellcode:
    db 'shellcode.bin',0

SECTION .text               ; Text section, for executable code

global main                ; standard entry point
main:

    push ebp                ; standard function prologue to setup stack frame
    mov ebp, esp            ; we will examine this later
    sub esp, 0x14           ; allocating stack space

    ; +0x0C: argv
    ; +0x08: argc
    ; +0x04: ret address
    ;  0x00: ebp
    ; -0x04: buffer  access using [ebp-0x04]
    ; -0x08: length  access using [ebp-0x08]
    ; -0x0C: arg2
    ; -0x10: arg1
    ; -0x14: arg0
    ; Above is my silly convention for describing how I will use the stack
    ; space that I allocated. The '+' prefixed values were passed into our
    ; function by its parent. The '-' prefixed values is the space I have
    ; explicitly allocated for myself.
    ; Stack space is one of the most complicated parts of assembly programming
    ; and we will be examining this in depth later. 

    ; START DO NOT MODIFY
.setup:
    lea eax, [ebp-0x04]         ; We are passing a local variable to the init
    mov dword [esp+8], eax      ; function. This is actually a location on the
                                ; stack where the init function will write the
                                ; buffer's address. A "pointer to a pointer" if
                                ; you like. Later, you will dereference this 
                                ; location to get the buffer pointer.
    mov eax, shellcode
    mov dword [esp+4], eax

    mov dword [esp], 2          ; the '0' here indicates the level of difficulty
                                ; '0' is easiest and should work out of the box
                                ; '1' is harder -> you have to search for the beginning
                                ; '2' is hardest -> you have to decode once you have found it

    call SreLibPrepareEgg       ; This function loads some shellcode.
                                ; XORs the shellcode with 0x12
                                ; Allocates some memory.
                                ; Hides the shellcode in the memory.

    mov dword [ebp-0x08], eax   ; The function returns the length of the
                                ; shellcode. We will store this on our 
                                ; stack so that we are free to reuse eax.
    
    ; All of the above assembly is effectively equivalent to this C code: 
    ; char *buffer;
    ; ssize_t length;
    ; length = SreLibPrepareEgg( 0, path, &buffer );

    ; END DO NOT MODIFY
.setup_complete:


; Search for egg loop
.search_loop_init:
    mov edx, BUFFER_SIZE        ; get total size
    mov dword eax, [ebp-0x04]   ; get buffer pointer
    xor ecx, ecx                ; zero counter

.search_loop_cond:
    cmp ecx, edx                ; compare counter to buffer size
    jge .not_found              ; continue searching whilst count < buffer size
    
.search_loop_body:
    cmp dword [eax+ecx], EGG    ; have we found the egg?
    je .egg_found

.search_loop_incr:
    inc ecx                     ; counter += 1
    jmp .search_loop_cond               ; jump back to start
    
.egg_found:
    mov dword edx, [ebp-0x08]   ; get length
    add ecx, EGG_SIZE           ; advance start offset past egg
    add ecx, eax                ; add buffer pointer to start offset
    add edx, ecx                ; add length to start to get end

; Now de-obfuscate the remaiining buffer
.deob_loop_init:
    mov eax, ecx                ; make a copy of start to use later

.deob_loop_cond:
    cmp ecx, edx                ; compare start to end
    jge .deob_loop_complete     ; whilst start < end -> keep deobfuscating

.deob_loop_body:
    xor byte [ecx], XOR_VALUE   ; de-obfuscate byte

.deob_loop_incr:
    inc ecx
    jmp .deob_loop_cond

.deob_loop_complete:
    call eax                    ; call the copy of start we made earlier
    mov eax, EXIT_SUCCESS
    jmp .epilogue
    
.not_found:
    mov eax, EXIT_FAILURE
    
.epilogue:
    mov esp, ebp            ; standard function epilogue
    pop ebp
    ret                     ; return


