    List p = 18f4520
	#include<p18f4520.inc>
	CONFIG OSC = INTIO67
	CONFIG WDT = OFF
	org 0x00
	
    CLRF 0x03 ; clear 0x03
    MOVLW 0xA6
    MOVWF 0x00
    
    ANDLW b'11110000' ; get upper 4 bits
    MOVWF 0x02 ; save the upper 4 bits to 0x02
    
    MOVLW 0x79
    MOVWF 0x01
    ANDLW b'00001111' ; get lower 4 bits
    IORWF 0x02, F ; OR => merge the upper and lower 4 bits and save in 0x02
    
    MOVF 0x02, W ; load the result into WREG
    MOVWF 0x10 ; temp

Counter_Set:
    MOVLW 0x08 ; i = 8
    MOVWF 0x11 ; save i in 0x11
    
Count_Zero:
    BTFSS 0x10, 0 ; if the bit is 1, skip
    INCF 0x03 ; if the bit is 0, plus one
    
    RRNCF 0x10
    DECFSZ 0x11
    GOTO Count_Zero
    
Clear_Temp:
    CLRF 0x10
    CLRF 0x11
    end
    
    


