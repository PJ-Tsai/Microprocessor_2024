List p = 18f4520
#include<p18f4520.inc>
CONFIG OSC = INTIO67
CONFIG WDT = OFF
org 0x00

main:
    MOVLW 0x03 ; a1
    MOVWF 0x000
    MOVLW 0x04 ; a2
    MOVWF 0x001
    MOVLW 0x07 ; a3
    MOVWF 0x002

    MOVLW 0x05 ; b1
    MOVWF 0x010
    MOVLW 0x05 ; b2
    MOVWF 0x011
    MOVLW 0x03 ; b3
    MOVWF 0x012
    
    RCALL cross ; Call subroutine
    GOTO Over
    
cross:
    ; Calculate c1
    MOVFF 0x001, 0x004 ; 0x004 as mul_temp
    MOVF 0x012, W ; Calculate a2 * b3
    MULWF 0x004
    MOVF PRODL, W 
    MOVWF 0x020 ; Save in 0x020
    
    MOVFF 0x002, 0x004 ; 0x004 as mul_temp
    MOVF 0x011, W ; Calculate a3 * b2
    MULWF 0x004
    MOVF PRODL, W 
    SUBWF 0x020, F ; Result save in 0x020
    ; Calculate c2
    MOVFF 0x002, 0x004 ; 0x004 as mul_temp
    MOVF 0x010, W ; Calculate a3 * b1
    MULWF 0x004
    MOVF PRODL, W 
    MOVWF 0x021 ; Save in 0x021
    
    MOVFF 0x000, 0x004 ; 0x004 as mul_temp
    MOVF 0x012, W ; Calculate a1 * b3
    MULWF 0x004
    MOVF PRODL, W 
    SUBWF 0x021, F ; Result save in 0x021
    ; Calculate c3
    MOVFF 0x000, 0x004 ; 0x004 as mul_temp
    MOVF 0x011, W ; Calculate a1 * b2
    MULWF 0x004
    MOVF PRODL, W 
    MOVWF 0x022 ; Save in 0x022
    
    MOVFF 0x001, 0x004 ; 0x004 as mul_temp
    MOVF 0x010, W ; Calculate a2 * b1
    MULWF 0x004
    MOVF PRODL, W 
    SUBWF 0x022, F ; Result save in 0x022
    
    RETURN
    
Over:
    CLRF 0x004
    end
