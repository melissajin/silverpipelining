
;
; Expected Values
; R0 = 0x1A
; R1 = 0x01
; R2 = 0x02
; R3 = 0x03
; R4 = 0x04
; R5 = 0x05
; R6 = 0x06
; R7 = 0x07
;

ORIGIN 0
SEGMENT
CODE:
	LEA R0, DATA
	ADD R1, R0, 1
	NOP
	NOP
	NOP
	NOP
	LDI R2, R0, LVAL2
	NOP
	NOP
	NOP
	NOP
	STI R2, R0, 0
DONE:
	BR DONE
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP

SEGMENT
DATA:
LVAL1:  DATA2 ?
LVAL2:  DATA2 GOOD
LVAL3:  DATA2 ?
SVAL1:  DATA2 ?
SVAL2:  DATA2 ?
SVAL3:  DATA2 ?
SVAL4:  DATA2 ?
GOOD:   DATA2 4x600D
BADD:   DATA2 ?
