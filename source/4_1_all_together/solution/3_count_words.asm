; Count Words
; int count_words( char *buffer, size_t size )
; returns the number of words in the buffer
; words printable characters delimeted by whitespace or non-printable characters
; Joshua Thornton 2015

; External Imports
extern SreLibIsSpace 
extern SreLibIsPrint

SECTION .text

global count_words
count_words:

.prologue:
    push ebp
    mov ebp, esp
    sub esp, 0x14
    ; +0x0C : size
    ; +0x08 : buffer
    ; +0x04 : ret
    ;  0x00 : ebp   
    ; -0x04 : edi backup
    ; -0x08 : esi backup
    ; -0x0C : ebx backup
    ; -0x10 : number of words
    ; +0x00 : arg0

    ; Register / Locals Usage
    ; edi = buffer
    ; ebx = size
    ; esi = currently in a word
    ; [ebp-0x10] = number of words
    
.preserve_registers:
    mov [ebp-0x4], edi
    mov [ebp-0x8], esi
    mov [ebp-0xC], ebx
    
.loop_init:
    ; read in arguments
    mov edi, [ebp+0x8]  ; read in buffer
    mov ebx, [ebp+0xC]  ; read in size
    
    xor esi, esi        ; zero currently in word state
    mov [ebp-0x10], esi ; zero word counter

.loop_cond:
    cmp ebx, 0x00
    jz .loop_end

.loop_body:
    
    ; check if current character is printable
    movzx eax, byte [edi+ebx-1] ; get a character from buffer
    
    ; pass character to is printable
    mov [esp+0x00], eax     ; arg0 = a character
    call SreLibIsPrint
    
    ; Are we printable?
    cmp eax, 0x00
    je .not_in_word
    
    ; Check if current character is whitespace
    movzx eax, byte [edi+ebx-1]
    mov [esp+0x00], eax
    call SreLibIsSpace
    
    ; Are we a space?
    cmp eax, 0x00
    jne .not_in_word
    
    ; Ok -> we definitely just found a word character, but are we already in a word
    cmp esi, 0x00           ; are we in a word?
    jnz .loop_incr          ; already in a word -> just continue to next char
    
.found_a_new_word:
    mov esi, 0x01           ; set our "in a word" state
    inc dword [ebp-0x10]    ; increment our word counter
    jmp .loop_incr          ; continue to next char

.not_in_word:
    xor esi, esi            ; zero our "in a word" state

.loop_incr:
    dec ebx                 ; decrement size
    jmp .loop_cond          ; go back to condition

.loop_end:
    
    ; move word counter to eax
    mov eax, [ebp-0x10]
    
.restore_registers:
    mov edi, [ebp-0x4]
    mov esi, [ebp-0x8]
    mov ebx, [ebp-0xC]

.epilogue:
    mov esp, ebp
    pop ebp
    ret