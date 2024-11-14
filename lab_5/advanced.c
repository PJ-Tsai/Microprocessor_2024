#include<xc.h>
extern unsigned int gcd(unsigned int a, unsigned int b);

void main(void) {
    volatile unsigned int result = gcd(33333, 22222); // input and get the result
    while(1);
    return;
}

