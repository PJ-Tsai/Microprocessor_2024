List p = 18f4520
#include<p18f4520.inc>
CONFIG OSC = INTIO67
CONFIG WDT = OFF
org 0x00

    LFSR 0, 0x100       ; Set FSR0 to point to 0x100 (start of the array)

    MOVLW 0x00        ; Store 0x08 at address 0x100
    MOVWF POSTINC0

    MOVLW 0x01          ; Store 0x7C at address 0x101
    MOVWF POSTINC0

    MOVLW 0x02          ; Store 0x78 at address 0x102
    MOVWF POSTINC0

    MOVLW 0x03          ; Store 0xFE at address 0x103
    MOVWF POSTINC0

    MOVLW 0x04          ; Store 0x34 at address 0x104
    MOVWF POSTINC0

    MOVLW 0x05          ; Store 0x7A at address 0x105
    MOVWF POSTINC0

    MOVLW 0x06          ; Store 0x0D at address 0x106
    MOVWF POSTINC0
    
    MOVLW 0x06          ; Outer loop runs 6 times (number of elements - 1)
    MOVWF 0x110          ; Store outer loop counter in 0x110
    
Outer_Loop:
    DECF 0x110
    BTFSC STATUS, Z
    GOTO Over
    MOVLW 0x06
    MOVWF 0x111
    LFSR 0, 0x100
    LFSR 1, 0x101
    
Inner_Loop:
    MOVF INDF0, W ; WREG = FSR1
    CPFSLT INDF1
    GOTO No_Swap
    
    MOVF INDF0, W
    MOVFF INDF1, INDF0
    MOVWF INDF1

No_Swap:
    MOVF POSTINC0, W
    MOVF POSTINC1, W
    DECF 0x111
    BTFSC STATUS, Z
    GOTO Outer_Loop
    GOTO Inner_Loop
    
Over:
    end

   