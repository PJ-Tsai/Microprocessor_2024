List p = 18f4520
#include<p18f4520.inc>
CONFIG OSC = INTIO67
CONFIG WDT = OFF
org 0x00
    
    MOVLW d'24' ; n
    MOVWF 0x010
Initial:
    MOVLW 0x00 ; F0_h
    MOVWF 0x020 
    MOVLW 0x00 ; F0_l
    MOVWF 0x021
    MOVLW 0x00 ; F1_h
    MOVWF 0x022 
    MOVLW 0x01 ; F1_l
    MOVWF 0x023
    
    MOVLW 0x00
    CPFSGT 0x010, 1 ; If n > 0, skip
    GOTO Fib_0
    MOVLW 0x01
    CPFSGT 0x010, 1 ; If n > 1, skip
    GOTO Fib_1
    
    RCALL fib
    GOTO Over
    
fib:
    DCFSNZ 0x010 ; If n-- != 0, skip
    RETURN
    
    BCF STATUS, C
    MOVFF 0x020, 0x030
    MOVFF 0x021, 0x031
    MOVF 0x022, W
    ADDWF 0x030, F ; 0x030 = 0x020 + 0x022
    MOVF 0x023, W
    ADDWF 0x031, F ; 0x031 = 0x021 + 0x023
    BTFSC STATUS, C ; If Carry, high byte++
    INCF 0x030, F
    ; Update new Fn and answer
    MOVFF 0x022, 0x020
    MOVFF 0x023, 0x021
    MOVFF 0x030, 0x022
    MOVFF 0x031, 0x023
    MOVFF 0x030, 0x000
    MOVFF 0x031, 0x001
    
    GOTO fib
    
Fib_0: 
    MOVFF 0x020, 0x000
    MOVFF 0x021, 0x001
    GOTO Over

Fib_1: 
    MOVFF 0x022, 0x000
    MOVFF 0x023, 0x001
    GOTO Over
    
Over: 
    CLRF 0x010
    CLRF 0x020
    CLRF 0x021
    CLRF 0x022
    CLRF 0x023
    CLRF 0x030
    CLRF 0x031
    end
