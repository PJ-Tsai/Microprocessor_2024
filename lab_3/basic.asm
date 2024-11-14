List p = 18f4520
#include<p18f4520.inc>
CONFIG OSC = INTIO67
CONFIG WDT = OFF
org 0x00
    
    CLRF TRISA
    MOVLW 0xC8 
    MOVWF TRISA
    
    BCF STATUS, C
    RLCF TRISA, F
    
    BCF STATUS, C
    BTFSC TRISA, 7
    BSF STATUS, C
    RRCF TRISA, F
    
Over:
    end
    


