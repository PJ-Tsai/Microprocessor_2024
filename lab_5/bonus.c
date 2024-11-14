#include<xc.h>
extern unsigned int multi_signed(unsigned char a, unsigned char b);

void main(void) {
    volatile unsigned int result = multi_signed(-20,-4); // input and get the result
    while(1);
    return;
}
