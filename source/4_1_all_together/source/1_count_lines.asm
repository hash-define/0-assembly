; Count Lines
; int count_lines( char *buffer, size_t size )
; returns the number of lines in the file
; Joshua Thornton 2015

NEW_LINE_CHAR   equ 10
SECTION .text

global count_lines
count_lines:

    push ebp
    mov ebp, esp
    sub esp, 0x04
    ; +0x0C size
    ; +0x08 buffer
    ; +0x04 ret address
    ;  0x00 ebp
    ; -0x04 esi

    ; eax, ecx, edx are not preserved across function calls
    ; ebx, esi, edi, ebp, esp must be preserved across function calls
    ; save esi so that we can use this register
    mov dword [ebp-0x04], esi

.read_in_args:
    mov ecx, [ebp+0x0C] ; read in size
    mov esi, [ebp+0x08] ; read in buffer

    ; To help you out, document your register choices here:
    ; ecx = size of buffer
    ; esi = buffer pointer
    ; eax = 
    ; edx = 
    ; if you want to use ebx or edi you are going to need to allocate
    ; additional stack space to save and restore them before use.
    ; If you want to call a function, remember that anything stored in
    ; eax, ecx and edx will no longer be accurate.

.epilogue:
    ; restore esi after use
    mov esi, dword [ebp-0x04]
    mov esp, ebp
    pop ebp
    ret
