#include "xc.inc"
GLOBAL _mysqrt
PSECT mytext,local,class=CODE,reloc=2
 
_mysqrt:
    CLRF 0x10
    CLRF 0x11
    CLRF 0x12
    CLRF 0x01
    MOVWF 0x10 ; save a in 0x010
    MOVLW 0x01
    MOVWF 0x11 ; initailize n
    MOVWF 0x12 ; initailize n ^ 2
    GOTO find
    
find:
    MOVF 0x10, W 
    CPFSLT 0x12 ; if 0x012 < wreg(0x010), skip
    GOTO over
    INCF 0x11, F ; n++
    MOVLW 0x10 ; check whether 0x011 > 15 or not
    CPFSLT 0x11 ; if 0x011 > 15, go to find
    GOTO over
    MOVF 0x11, W ; wreg = n
    MULWF 0x11 ; calculate n * n
    MOVFF PRODL, 0x12 ; move n ^ 2 to 0x012
    GOTO find
    
over:
    MOVFF 0x11, WREG ; return n
    RETURN