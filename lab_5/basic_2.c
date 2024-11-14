#include<xc.h>
extern unsigned char mysqrt(unsigned char a);

void main(void) {
    volatile unsigned char result = mysqrt(25); // input and get the result
    while(1);
    return;
}

