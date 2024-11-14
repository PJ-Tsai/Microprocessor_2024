#include "xc.inc"
GLOBAL _gcd
PSECT mytext,local,class=CODE,reloc=2

_gcd:
    MOVF 0x02, W ; load a_high
    SUBWF 0x04, W ; sub b_high

    BZ Compare_Low ; if equal, goto low bits compare
    BNC A_Is_Bigger ; check which one is bigger
    GOTO B_Is_Bigger

Compare_Low:
    MOVF 0x01, W ; load a_low
    SUBWF 0x03, W ; sub b_load

    BNC A_Is_Bigger ; check which one is bigger
    GOTO B_Is_Bigger

A_Is_Bigger:
    goto Euclidean

B_Is_Bigger:
    MOVFF 0x01, 0x11 ; move a_low to temp
    MOVFF 0x02, 0x12 ; move a_high to temp
    MOVFF 0x03, 0x01 ; move b_low to bigger_low
    MOVFF 0x04, 0x02 ; move b_low to bigger_high
    MOVFF 0x11, 0x03 ; move a_low to smaller_low
    MOVFF 0x12, 0x04 ; move a_high to smaller_high
    goto Euclidean

Euclidean:
    ; calculate a = a - b until b == 0
    MOVF 0x02, W ; load a_high
    SUBWF 0x04, W ; a_high - b_high
    BNZ Subtract ; if not equal 0, goto subtract
    MOVF 0x01, W ; load a_low
    SUBWF 0x03, W ; a_high - b_high
    BNZ Subtract ; if not equal, goto subtract

End_GCD:
    CLRf 0x03
    CLRF 0x04
    CLRF 0x11
    CLRF 0x12
    RETURN

Subtract:
    ; calculate a - b
    MOVF 0x03, W ; load b_low
    SUBWF 0x01, F ; a_low = a_low - b_low
    BC Skip_Decrement ; 
    DECF 0x02, F ; a_high--
Skip_Decrement:
    MOVF 0x04, W ; load b_high
    SUBWF 0x02, F ; a_high = a_high - b_high
    GOTO _gcd ; continue

    
