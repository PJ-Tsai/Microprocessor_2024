List p = 18f4520
#include<p18f4520.inc>
CONFIG OSC = INTIO67
CONFIG WDT = OFF
org 0x00
    
    CLRF 0x002
    CLRF 0x003
    MOVLW 0x00
    MOVWF 0x000 ; Save the high bits 
    MOVLW 0x40
    MOVWF 0x001 ; save the low bits

    MOVLW 0x00
    CPFSGT 0x000 ; If 0x000 == 0 goto lower
    GOTO Lower
    MOVLW 0x08
    MOVWF 0x002
    MOVF 0x000, W
    MOVWF 0x004
    GOTO Divide_2

Lower:
    MOVF 0x001, W 
    MOVWF 0x004
    GOTO Divide_2
    
Divide_2:
    RRCF 0x004
    BTFSC STATUS, C
    GOTO Rounding
    BCF STATUS, C
    MOVLW 0x00
    CPFSGT 0x004 ; If 0x004 == 0 goto Over
    GOTO Over
    INCF 0x002
    GOTO Divide_2
    
Rounding:
    INCF 0x003
    BCF STATUS, C
    MOVLW 0x00
    CPFSGT 0x004 ; If 0x004 == 0 goto Over
    GOTO Over
    INCF 0x002
    GOTO Divide_2
    
Over:
    MOVLW 0x00
    CPFSEQ 0x001 ; IF 0x001 > 0, 0x003++
    INCF 0x003
    
    MOVLW 0x03
    CPFSLT 0x003 ; If 0x003 > 2 ,.do rounding
    INCF 0x002
    
    CLRF 0x03
    end