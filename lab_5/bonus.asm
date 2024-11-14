#include "xc.inc"
GLOBAL _multi_signed
PSECT mytext,local,class=CODE,reloc=2
    
_multi_signed:
    ; a is in WREG, and b is in 0x01
    ; save a in 0x10 and b in 0x11
    MOVWF 0x10 ; save a in 0x10
    MOVF 0x01, W ; load b into wreg
    BZ Equal_0
    MOVWF 0x11 ; save b in 0x11
    
    MOVLW 0x00 ; wreg = 0
    SUBWF 0x10, W     ; wreg = 0x00 - 0x10
    BNN A_Is_Positive ; if a >= 0, goto A_Is_Positive

A_Is_Negative:
    ; if a is negative, convert it to positive (2's complement)
    COMF 0x10, F
    INCF 0x10, F ; add 1 to complete two's complement
    MOVLW 0x01 ; store a's sign flag
    MOVWF 0x12 ; store the sign in 0x12
    GOTO Check_B_Sign

A_Is_Positive:
    ; If a is positive, no need to do anything
    MOVLW 0x00 ; sign of a is 0
    MOVWF 0x12 ; store a's sign flag

Check_B_Sign:
    MOVLW 0x00 ; wreg = 0
    SUBWF 0x11, W ; wreg = 0x00 - 0x11
    BNN B_Is_Positive ; if b >= 0, goto B_Is_Positive

B_Is_Negative:
    ; If b is negative, convert it to positive (2's complement)
    COMF 0x11, F
    INCF 0x11, F ; add 1 to complete two's complement
    MOVLW 0x01 ; store b's sign flag
    XORWF 0x12, F ; toggle the sign flag (exclusive OR)

B_Is_Positive:
    CLRF 0x01 ; clear result_low
    CLRF 0x02 ; clear result_high
    
Multiplication:
    MOVF 0x10, W ; load a to wreg
    ADDWF 0x01, F ; add to result_low
    BC High_Byte_Plus ; if carry, goto High_Byte_Plus
    DECFSZ 0x11 ; loop cnt--
    GOTO Multiplication ; continue
    GOTO After_Mul ; deal with sign flag
    
High_Byte_Plus:
    INCF 0x02 ; result_high++
    DECFSZ 0x11 ; loop cnt--
    GOTO Multiplication ; continue
    GOTO After_Mul ; deal with sign flag

After_Mul:
    MOVF 0x12, W ; load 0x12 to wreg
    BZ Over ; if 0, goto Over
    COMF 0x01 ; complement
    INCF 0x01
    COMF 0x02
    
Over:
    CLRF 0x10
    CLRF 0x11
    CLRF 0x12
    RETURN
    
Equal_0:
    MOVLW 0x00
    MOVWF 0x01
    MOVWF 0x02
    RETURN