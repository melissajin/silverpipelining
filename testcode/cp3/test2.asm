
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
	NOP
	NOP
	NOP
	LDR R1, R0, LVAL1
	LDR R2, R0, LVAL2				;WB -> EX forward_b
	ADD R3, R1, R2
	LDR R4, R0, LVAL3				;WB -> EX forward_a
	ADD R5, R4, R1
	ADD R6, R1, R5					;MEM -> EX forward_b
	ADD R7, R6, R1					;MEM -> EX forward_b

SEGMENT
DATA:
LVAL1:  DATA2 4x0001
LVAL2:  DATA2 4x0002
LVAL3:  DATA2 4x0004
SVAL1:  DATA2 ?
SVAL2:  DATA2 ?
SVAL3:  DATA2 ?
SVAL4:  DATA2 ?
GOOD:   DATA2 4x600D
BADD:   DATA2 4xBADD
