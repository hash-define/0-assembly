; 0_count_chars.asm
; int count_chars( char *buffer, size_t size )
; returns the number of non-whitespace printable characters in the buffer
; Joshua Thornton 2015

; External Imports
extern SreLibIsPrint
extern SreLibIsSpace 

SECTION .text               ; Text section, for executable code

global count_chars          ; expose our symbol globally
count_chars:
    push ebp
    mov ebp, esp
    sub esp, 0x10
    ; +0x0C size
    ; +0x08 buffer
    ; +0x04 ret address
    ;  0x00 ebp
    ; -0x04 ebx
    ; -0x08 esi
    ; -0x0C edi
    ; -0x10 reserve space for one argument

    ; ebx must be preserved across calls
    ; if we want to use it here we have to save it beforehand
    ; and restore it afterwards
    mov dword [ebp-0x04], ebx
    ; same for esi and edi
    mov dword [ebp-0x08], esi
    mov dword [ebp-0x0C], edi

    ; My made up register convention for this function is
    ; eax: ret value (can't change this) 
    ; esi: buffer
    ; edi: counter
    ; ebx: size 
    ; ecx and edx are unused. They are poor choices for storing state because
    ; we call a lot of functions and they are not preserved across functions.

    mov dword esi, [ebp+0x08]   ; get buffer
    mov dword ebx, [ebp+0x0C]   ; get size

    ; zero my char counter
    xor edi, edi

    ; loop through buffer
    ; while ( size != 0 )
.loop_cond:
    cmp ebx, 0
    jle .loop_exit

.loop_body:

    ; get next character
    ; char c = *buffer;
    ; int a = (int)c; // SreLibIsPrint and SreLibIsSpace take an int
    mov byte al, [esi]
    movzx eax, al

    ; Count the char if it is printable and not whitespace
    ; if ( _SreLibIsPrint( c ) && !_SreLibIsSpace( c ) )
    ;   count++
    mov dword [esp], eax
    call SreLibIsPrint

    ; check return value from _SreLibIsPrint
    cmp eax, 0
    je .loop_increment
    
    ; char c = *buffer;
    mov byte al, [esi]
    movzx eax, al

    mov dword [esp], eax    ; technically this is not necessary since our value
                            ; will still be on the stack in the same place from
                            ; last time
    call SreLibIsSpace
    cmp eax, 0
    jne .loop_increment

    ; Character is printable and not whitespace! Count it!
    inc edi

.loop_increment:
    dec ebx         ; decrement size
    inc esi         ; increment buffer 
    jmp .loop_cond  ; jump back to condition testing

.loop_exit:

    ; save ret value
    mov eax, edi 

    mov dword edi, [ebp-0x0C]   ; restoring edi
    mov dword esi, [ebp-0x08]   ; restoring esi
    mov dword ebx, [ebp-0x04]   ; restoring edx
    mov esp, ebp
    pop ebp
    ret
