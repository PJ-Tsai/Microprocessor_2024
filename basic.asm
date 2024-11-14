List p = 18f4520
#include<p18f4520.inc>
CONFIG OSC = INTIO67
CONFIG WDT = OFF
org 0x00

    LFSR 0, 0x100 ; Set FSR0 to 0x100
    LFSR 1, 0x116 ; Set FSR1 to 0x116
    LFSR 2, 0x108 ; Set FSR2 to 0x108
    MOVLW 0x06 ; Set loop counter
    MOVWF INDF2 ; 0x108 is the loop cunter
    
    MOVLW 0x01 ; Load WREG with 0x00
    MOVWF INDF0 ; Store 0x00 at address 0x100

    MOVLW 0x00 ; Load WREG with 0x01
    MOVWF INDF1 ; Store 0x01 at address 0x116

loop:
    ADDWF POSTINC0, W ; W += FSR0, FSR0++
    MOVWF INDF0 ; Store W at FSR0
    
    ADDWF POSTDEC1, W ; W += FSR1, FSR1--
    MOVWF INDF1 ; Store W at FSR1
    
    DECF INDF2, F ; Loop counter--
    BTFSS STATUS, Z ; Check if the zero flag is set (loop counter is zero)
    GOTO loop ; If not zero, repeat the loop
    
    end

    