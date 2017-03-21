;;
;; This program is a test of LDI and STI
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
	;;
	;; Make sure that the contents of memory in ModelSim match
	;; the contents of memory in the LC3bSimulator.
	;;

	LEA R0, DATA
	;; Testing LDI
	LDI R1, R0, PTR_LVAL_1
	LDI R2, R0, PTR_LVAL_2
	LDI R3, R0, PTR_LVAL_3
	LDI R4, R0, PTR_LVAL_4
	LDI R5, R0, PTR_LVAL_5
	LDI R6, R0, PTR_LVAL_6
	LDI R7, R0, PTR_LVAL_7

	;; Testing STI
	STI R1, R0, PTR_SVAL_1
	STI R2, R0, PTR_SVAL_2
	STI R3, R0, PTR_SVAL_3
	STI R4, R0, PTR_SVAL_4
	STI R5, R0, PTR_SVAL_5
	STI R6, R0, PTR_SVAL_6
	STI R7, R0, PTR_SVAL_7

	;; Testing STI


HALT_PROG:
	BRnzp HALT_PROG

SEGMENT
DATA:
LVAL_1: 		DATA2 4x0001 ;; Args for testing LDI and STI
LVAL_2: 		DATA2 4x0002 ;; Args for testing LDI and STI
LVAL_3: 		DATA2 4x0003 ;; Args for testing LDI and STI
LVAL_4: 		DATA2 4x0004 ;; Args for testing LDI and STI
LVAL_5: 		DATA2 4x0005 ;; Args for testing LDI and STI
LVAL_6: 		DATA2 4x0006 ;; Args for testing LDI and STI
LVAL_7: 		DATA2 4x0007 ;; Args for testing LDI and STI

SVAL_1: 		DATA2 ? 	 ;; Args for testing LDI and STI
SVAL_2: 		DATA2 ? 	 ;; Args for testing LDI and STI
SVAL_3: 		DATA2 ? 	 ;; Args for testing LDI and STI
SVAL_4: 		DATA2 ? 	 ;; Args for testing LDI and STI
SVAL_5: 		DATA2 ? 	 ;; Args for testing LDI and STI
SVAL_6: 		DATA2 ? 	 ;; Args for testing LDI and STI
SVAL_7: 		DATA2 ? 	 ;; Args for testing LDI and STI

PTR_LVAL_1: 	DATA2 LVAL_1 ;; Args for testing LDI and STI
PTR_LVAL_2: 	DATA2 LVAL_2 ;; Args for testing LDI and STI
PTR_LVAL_3: 	DATA2 LVAL_3 ;; Args for testing LDI and STI
PTR_LVAL_4:		DATA2 LVAL_4 ;; Args for testing LDI and STI
PTR_LVAL_5:		DATA2 LVAL_5 ;; Args for testing LDI and STI
PTR_LVAL_6:		DATA2 LVAL_6 ;; Args for testing LDI and STI
PTR_LVAL_7:		DATA2 LVAL_7 ;; Args for testing LDI and STI

PTR_SVAL_1: 	DATA2 SVAL_1 ;; Args for testing LDI and STI
PTR_SVAL_2: 	DATA2 SVAL_2 ;; Args for testing LDI and STI
PTR_SVAL_3: 	DATA2 SVAL_3 ;; Args for testing LDI and STI
PTR_SVAL_4:		DATA2 SVAL_4 ;; Args for testing LDI and STI
PTR_SVAL_5:		DATA2 SVAL_5 ;; Args for testing LDI and STI
PTR_SVAL_6:		DATA2 SVAL_6 ;; Args for testing LDI and STI
PTR_SVAL_7:		DATA2 SVAL_7 ;; Args for testing LDI and STI
