List p = 18f4520
#include<p18f4520.inc>
CONFIG OSC = INTIO67
CONFIG WDT = OFF
org 0x00
    
    ; xh, xl, yh, yl => 0x020, 0x021, 0x022, 0x023
Sub_Mul MACRO xh, xl, yh, yl
    MOVFF xh, 0x000 ; Save Xh in 0x000
    MOVF yh, W 
    SUBWF 0x000, F ; High bytes sub
    MOVFF xl, 0x001 ; Save Xl in 0x001
    MOVF yl, W
    SUBWF 0x001, F ; Low bytes sub
    BTFSS STATUS, C ; If borrow, high byte--
    DECf 0x000, F 
    MOVF 0x000, W
    MULWF 0x001 ; PROD = 0x000 * 0x001
    MOVF PRODH, W 
    MOVWF 0x010 ; Save PRODH in 0x010
    MOVF PRODL, W
    MOVWF 0x011 ; Save PRODL in 0x011
	
    ENDM

main: 
    MOVLW 0x03 ; xh
    MOVWF 0x020
    MOVLW 0xA5 ; xl
    MOVWF 0x021
    MOVLW 0x02 ; yh
    MOVWF 0x022
    MOVLW 0xA7 ; yl
    MOVWF 0x023
    
    Sub_Mul 0x020, 0x021, 0x022, 0x023 ; Using macro
    
    end
