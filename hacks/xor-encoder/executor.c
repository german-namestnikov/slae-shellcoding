#include<stdio.h>
#include<string.h>

unsigned char shellcode[] = 
"";

int main()
{
    printf("Shellcode Length: %d\n", strlen(shellcode));
    int (*ret)() = (int(*)())shellcode;
 
    ret();
}
