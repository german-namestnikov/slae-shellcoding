#include<stdio.h>
#include<string.h>

/*
1. Make egghunter code with 'objdump':

german@slae-lab:~/slae-shellcoding$ objdump -d ./access_egghunter |grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

"\x31\xd2\x66\x81\xca\xff\x0f\x42\x8d\x5a\x04\x6a\x21\x58\xcd\x80\x3c\xf2\x74\xee\xb8\x41\x41\x41\x41\x89\xd7\xaf\x75\xe9\xaf\x75\xe6\xff\xe7"

2. Compile with 'gcc -fno-stack-protector -z execstack executor.c -o executor'
*/

unsigned char egghunter[] = 
"\x31\xd2\x66\x81\xca\xff\x0f\x42\x8d\x5a\x04\x6a\x21\x58\xcd\x80\x3c\xf2\x74\xee\xb8"
"W00T"
"\x89\xd7\xaf\x75\xe9\xaf\x75\xe6\xff\xe7";

unsigned char shellcode[] =
"W00TW00T\xcc\xcc";

int main()
{
    printf("Shellcode Length: %d\n", strlen(egghunter));
    int (*ret)() = (int(*)())egghunter;
 
    ret();
}
