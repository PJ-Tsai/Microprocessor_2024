    List p = 18f4520
	#include<p18f4520.inc>
	CONFIG OSC = INTIO67
	CONFIG WDT = OFF
	org 0x00
    
    MOVLW 0x07
    MOVWF 0x00 ; save the value into 0x00
    
    MOVLW 0x09
    MOVWF 0x01 ; save the value into 0x01
 
    ADDWF 0x00, W ; WREG += 0x00
    MOVWF 0x02 ; 0x02 = 0x00 + 0x01
    
    MOVLW 0x12
    MOVWF 0x10 ; save the value into 0x10
    
    MOVLW 0x01
    MOVWF 0x11 ; save the vlaue into 0x11
 
    SUBWF 0x10, W ; WREG -= 0x10
    MOVWF 0x12 ; 0x12 = 0x11 - 0x10
    
    CPFSEQ 0x02  ; check if equal
    GOTO Check_Gt ; if not equal, goto check_gt
    MOVLW 0xBB
    MOVWF 0x20 ; if equal, 0x20 = 0xBB
    GOTO End_Compare

Check_Gt:
    CPFSGT 0x02, 0x12 ; compare 0x02 and 0x12
    GOTO Check_Lt ; if not greater, goto check_lt
    MOVLW 0xAA
    MOVWF 0x20 ; if greater, 0x20 = 0xAA
    GOTO End_Compare 

Check_Lt:
    MOVLW 0xCC
    MOVWF 0x20 ; if less than, 0x20 = 0xCC

End_Compare:
    end
