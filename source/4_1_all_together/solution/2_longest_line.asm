; Longest Line 
; int longest_line( char *buffer, size_t size )
; returns the longest line in the file
; Joshua Thornton 2015

NEW_LINE_CHAR   equ 10
SECTION .text

global longest_line
longest_line:

.prologue:
    push ebp
    mov ebp, esp
    sub esp, 4
    ; +0x0C : size
    ; +0x08 : buffer
    ; +0x04 : ret
    ;  0x00 : ebp   
    ; -0x04 : longest line  
    
    ; Register/locals usage
    ; edx = buffer
    ; ecx = size / counter
    ; eax = length of line
    ; [ebp-4] = longest line
    
.loop_init:
    ; read in arguments
    mov edx, [ebp+0x8]  ; read in buffer
    mov ecx, [ebp+0xC]  ; read in size
    
    xor eax, eax        ; zero length of line
    mov [ebp-4], eax    ; zero longest line counter

.loop_cond:
    cmp ecx, 0
    je .loop_end

.loop_body:
    
    ; Check if new line found
    cmp byte [edx+ecx-1], NEW_LINE_CHAR
    jz .new_line_found

.not_a_new_line:
    inc eax             ; increment length of current line
    jmp .loop_incr
    
.new_line_found:
    
    ; compare against current longest line
    cmp eax, [ebp-4]
    jle .not_longest
    
.longest_line_yet:
    mov [ebp-4], eax    ; save the longest line
    
.not_longest:
    xor eax, eax        ; reset length of current line

.loop_incr:
    dec ecx             ; decremnt size
    jmp .loop_cond

.loop_end:

    ; Now, our final line might be the longest, cmp it to stored
    cmp [ebp-4], eax
    jle .epilogue

    ; put the longest line result into eax
    mov eax, [ebp-4]

.epilogue:
    mov esp, ebp
    pop ebp
    
    ret