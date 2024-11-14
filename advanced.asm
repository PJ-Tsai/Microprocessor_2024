List p = 18f4520
#include<p18f4520.inc>
CONFIG OSC = INTIO67
CONFIG WDT = OFF
org 0x00
    
    CLRF 0x020
    CLRF 0x021
    CLRF 0x022
    CLRF 0x023
    
    MOVLW 0x77
    MOVWF 0x000 ; a1
    
    MOVLW 0x77
    MOVWF 0x001 ; a0
   
    MOVLW 0x56
    MOVWF 0x010 ; b1
    
    MOVLW 0x78
    MOVWF 0x011 ; b0
    
Multiply:
    ; Block 1
    MOVF 0x011, W ; W = 0x011 (b0) 
    MULWF 0x001 ; a0 * b0
    
    MOVF PRODL, W
    ADDWF 0x023, F ; Save the low bits of a0 * b0
    MOVF PRODH, W
    ADDWF 0x022, F ; Save the high bits of a0 * b0
    
    ; Block 2
    MOVF 0x011, W ; W = 0x011 (b0)
    MULWF 0x000 ; a1 * b0
    
    MOVF PRODL, W
    ADDWF 0x022, F ; Save the low bits of a1 * b0
    BTFSC STATUS, C
    INCF 0x021
    MOVF PRODH, W
    ADDWF 0x021, F ; Save the high bits of a1 * b0
    BTFSC STATUS, C
    INCF 0x020
    
    ; Block 3
    MOVF 0x010, W ; W = 0x010 (b1)
    MULWF 0x001 ; a0 * b1
    
    MOVF PRODL, W
    ADDWF 0x022, F ; Save the low bits of a0 * b1
    BTFSC STATUS, C
    INCF 0x021
    BTFSC STATUS, C
    INCF 0x020
    MOVF PRODH, W
    ADDWF 0x021, F ; Save the high bits of a0 * b1
    BTFSC STATUS, C
    INCF 0x020
    
    ; Block 4
    MOVF 0x010, W ; W = 0x010 (b1)
    MULWF 0x000 ; a1 * b1
    
    MOVF PRODL, W
    ADDWF 0x021, F ; Save the low bits of a1 * b1
    BTFSC STATUS, C
    INCF 0x020
    MOVF PRODH, W
    ADDWF 0x020, F ; Save the high bits of a0 * b1
    
Over:
    end
    

    
    


