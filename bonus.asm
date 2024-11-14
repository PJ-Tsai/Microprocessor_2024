    List p = 18f4520
	#include<p18f4520.inc>
	CONFIG OSC = INTIO67
	CONFIG WDT = OFF
	org 0x00
	
    MOVLW 0xCC
    MOVWF 0x00 ; save the value into 0x00

    MOVLW 0x01
    MOVWF 0x10 ; save the value into 0x10
    
    MOVF 0x00, W ; load the 0x00 into WREG
    MOVWF 0x20 ;temp

Main_Loop:
    MOVF 0x00, W  ; load the 0x00 into WREG
    ANDLW b'00000011' ; get the lowest 2 bits
    BTFSC STATUS, Z ; check the result is 0 or not
    GOTO Is_4x ; if the lowest 2 bits is 00

    MOVF 0x00, W ; load the 0x00 into WREG
    ANDLW b'00000001' ; get the lowest 1 bit
    BTFSC STATUS, Z 
    GOTO Is_2x; if the lowest 2 bits is 0
    DECF 0x10, F  ; dst--
    GOTO Rotate 

Is_4x:
    MOVLW 0x02 ; WREG = 2
    ADDWF 0x10, F ; dst += WREG
    GOTO Rotate 

Is_2x:
    INCF 0x10, F ; dst++
    GOTO Rotate

Rotate:
    RRNCF 0x00, F ; right shift
    MOVF 0x00, W ; load the 0x00 into WREG
    XORWF 0x20, W ; compare it is as same as original one or not
    BTFSS STATUS, Z ; check the result is 0 or not
    GOTO Main_Loop

Clear_Temp:
    CLRF 0x20
    end
     
    ; STATUS register
    ; C : Carry
    ; Z : Zero
    ; N : Negative

