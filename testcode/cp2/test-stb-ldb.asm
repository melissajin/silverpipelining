;;
;; This program is a test of LDB and STB
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

	NOP
	NOP
	NOP
	NOP
	NOP
	LEA R0, DATA
	NOP
	NOP
	NOP
	NOP
	NOP
	;; Testing LDB
	LDB R1, R0, 0
	NOP
	NOP
	NOP
	NOP
	NOP
	LDB R2, R0, 3
	NOP
	NOP
	NOP
	NOP
	NOP
	LDB R3, R0, 4
	NOP
	NOP
	NOP
	NOP
	NOP
	LDB R4, R0, 7
	NOP
	NOP
	NOP
	NOP
	NOP
	LDB R5, R0, 8
	NOP
	NOP
	NOP
	NOP
	NOP
	LDB R6, R0, 11
	NOP
	NOP
	NOP
	NOP
	NOP
	LDB R7, R0, 12
	NOP
	NOP
	NOP
	NOP
	NOP

	;; Testing STB
	STB R1, R0, 1
	NOP
	NOP
	NOP
	NOP
	NOP
	STB R2, R0, 2
	NOP
	NOP
	NOP
	NOP
	NOP
	STB R3, R0, 5
	NOP
	NOP
	NOP
	NOP
	NOP
	STB R4, R0, 6
	NOP
	NOP
	NOP
	NOP
	NOP
	STB R5, R0, 9
	NOP
	NOP
	NOP
	NOP
	NOP
	STB R6, R0, 10
	NOP
	NOP
	NOP
	NOP
	NOP
	STB R7, R0, 13
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

SEGMENT
DATA:
TVAL_1: 		DATA2 4x0001 ;; Args for testing LDB and STB
TVAL_2: 		DATA2 4x0200 ;; Args for testing LDB and STB
TVAL_3: 		DATA2 4x0003 ;; Args for testing LDB and STB
TVAL_4: 		DATA2 4x0400 ;; Args for testing LDB and STB
TVAL_5: 		DATA2 4x0005 ;; Args for testing LDB and STB
TVAL_6: 		DATA2 4x0600 ;; Args for testing LDB and STB
TVAL_7: 		DATA2 4x0007 ;; Args for testing LDB and STB
