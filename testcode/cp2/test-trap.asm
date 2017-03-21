;;
;; This program is a test of TRAP
;; In the comments you can find the expected end results for each register.
;; Other end conditions will also be speficied to make sure that success
;; has actually occured.
;;
;; Author: Rishi Thakkar
;; Date: 2/2/2017
;; Assignment: MP1
;;



ORIGIN 0
SEGMENT
CODE:

	;; ************* Expected End Results *************
	;; R0: 0x001E
	;; R1: Not Used
	;; R2: 0x0001
	;; R3: 0x0003
	;; R4: 0x0004
	;; R5 - R6: Not Used
	;; R7: 0x000E; Used for return address
	;;
	;; Make sure that the contents of memory and register values
	;; in ModelSim match the LC3bSimulator.
	;;

	;; Testing Trap
	NOP
	NOP
	NOP
	NOP
	NOP
	LEA R0, TRAP_ARGS
	NOP
	NOP
	NOP
	NOP
	NOP
	LDB R2, R0, 0			;; load byte: LDB_TVAL + 0
	NOP
	NOP
	NOP
	NOP
	NOP
	LDB R3, R0, 1			;; load byte: LDB_TVAL + 1
	NOP
	NOP
	NOP
	NOP
	NOP
	TRAP PTR_TRAP
	NOP
	NOP
	NOP
	NOP
	NOP
	ADD R2, R4, 0
	NOP
	NOP
	NOP
	NOP
	NOP
	TRAP PTR_TRAP
	NOP
	NOP
	NOP
	NOP
	NOP

HALT_PROG:
	NOP
	NOP
	NOP
	NOP
	NOP
	BRnzp HALT_PROG
	NOP
	NOP
	NOP
	NOP
	NOP

;; input: R2, R3
;; output: R4
TRAP_ADD_FUNC:
	NOP
	NOP
	NOP
	NOP
	NOP
	ADD R4, R3, R2
	NOP
	NOP
	NOP
	NOP
	NOP
	RET
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP

SEGMENT
DATA:
PTR_TRAP: 		DATA2 TRAP_ADD_FUNC
TRAP_ARGS: 		DATA2 4x0301 		;; Args for testing TRAP
