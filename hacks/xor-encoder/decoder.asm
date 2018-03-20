; encoder.asm
; Author: German Namestnikov

global _start

section .text
_start:
    jmp short call_decoder

decoder:
    pop esi            
    xor ecx, ecx
    mov cl, !LENGTHHERE!

decode:
    xor byte [esi], !KEYHERE!
    inc esi
    
    loop decode

    jmp short shellcode
    

call_decoder:
    call decoder
    shellcode: db !SHELLCODEHERE!
