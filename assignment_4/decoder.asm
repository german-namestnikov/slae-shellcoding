; encoder.asm
; Author: German Namestnikov

global _start

section .text
_start:
    jmp short call_decoder

decoder:
    pop esi		; esi points to the shellcode       
    mov edi, esi

    xor eax, eax
    mov al, !LENGTH!    ; shellcode length

    add edi, eax	; edi points to the positions    

    xor ecx, ecx        ; index of shellcode byte

iterate_shellcode:
    cmp cl, byte [edi]
    jnz next

    xor byte [esi], !KEY!
    inc edi

next:
    inc esi
    inc ecx   

    dec eax
    jz shellcode
    
    jmp iterate_shellcode
 
call_decoder:
    call decoder
     
    shellcode: db !SHELLCODE!
    positions: db !BADCHARSINDEXES!
