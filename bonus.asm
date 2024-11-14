List p=18f4520
#include<p18f4520.inc>
CONFIG OSC = INTIO67
CONFIG WDT = OFF
org 0x00

    LFSR 0, 0x000 ; Let FSR0 point to 0x000
    
    MOVLW 0x00 ; Store 0x28 at 0x000
    MOVWF POSTINC0

    MOVLW 0x11 ; Store 0x34 at 0x001
    MOVWF POSTINC0

    MOVLW 0x22 ; Store 0x7A at 0x002
    MOVWF POSTINC0

    MOVLW 0x33 ; Store 0x80 at 0x003
    MOVWF POSTINC0

    MOVLW 0x44 ; Store 0xA7 at 0x004
    MOVWF POSTINC0

    MOVLW 0x55 ; Store 0xD1 at 0x005
    MOVWF POSTINC0

    MOVLW 0x66 ; Store 0xFE at 0x006
    MOVWF POSTINC0
    
    MOVLW 0x00 ; Start index = 0
    MOVWF 0x013 ; Start index in 0x010
    
    MOVLW 0x06 ; End index = 6
    MOVWF 0x014 ; End index in 0x011

    
Binary_Search:
    MOVF 0x013, W ; Load start index
    ADDWF 0x014, W  ; Add end index
    RRCF WREG, F ; WREG / 2 (get midpoint)
    MOVWF 0x012 ; Store in 0x012

    LFSR 1, 0x000 ; Set FSR1 to point to the start of the array
    ADDWF FSR1L, F ; Let FSR1 point to midpoint

    MOVF INDF1, W ; Load midpoint
    SUBLW 0x33  ; Compare with 0xFE
    BTFSC STATUS, Z ; If the result is zero, found
    GOTO Found 
    
    MOVLW 0x33
    CPFSLT INDF1 ; If in larger, skip
    GOTO Search_Lower ; If 0xFE is smaller, search the lower half
    
    MOVF 0x012, W ; Load midpoint
    INCF WREG ; Next index
    MOVWF 0x013 ; Update start index (low)
    GOTO Continue_Search

Search_Lower:
    MOVF 0x012, W ; Load midpoint
    DECF WREG ; Previous index
    MOVWF 0x014 ; Update end index (high)

Continue_Search:
    MOVF 0x013, W ; Load start index
    CPFSLT 0x014 ; If start index lager than end index, skip(not found)
    GOTO Binary_Search ; Continue
    GOTO Not_Found 

Found:
    MOVLW 0xFF ; Load 0xFF into WREG
    MOVWF 0x011 ; Store at 0x011
    GOTO Over

Not_Found:
    MOVLW 0x00 ; Load 0x00 into WREG
    MOVWF 0x011 ; Store at 0x011

Over:
    CLRF 0x012 ; Clear
    CLRF 0x013
    CLRF 0x014
    end


