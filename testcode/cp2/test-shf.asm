;;
;; This program is a test of SHF
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
	;; Make sure that the contents of memory and register values
	;; in ModelSim match the LC3bSimulator.
	;;

	LEA R0, DATA

	;; Load values into registers
	LDR R1, R0, RSHFL_TVAL
	LDR R2, R0, RSHFL_TVAL
	LDR R3, R0, RSHFL_TVAL
	LDR R4, R0, RSHFL_TVAL
	LDR R5, R0, RSHFL_TVAL
	LDR R6, R0, RSHFL_TVAL
	LDR R7, R0, RSHFL_TVAL

	;; Testing RSHFL
	RSHFL R1, R1, 15		;; R1 <- 0x0001
	RSHFL R2, R2, 14		;; R2 <- 0x0003
	RSHFL R3, R3, 13		;; R3 <- 0x0007
	RSHFL R4, R4, 12		;; R4 <- 0x000F
	RSHFL R5, R5, 11		;; R5 <- 0x001F
	RSHFL R6, R6, 10		;; R6 <- 0x003F
	RSHFL R7, R7, 9			;; R7 <- 0x007F

	;; Testing RSHFA
	LDR R4, R0, RSHFA_TVAL
	RSHFA R3, R4, 8			;; R3 <-0xFF80
	RSHFA R2, R3, 7			;; R2 <-0xFFFF
	LDR R2, R0, RSHFA_TVAL
	RSHFA R1, R2, 6			;; R1 <-0xFE00

	;; Testing LSHF
	LDR R1, R0, LSHF_TVAL
	LSHF R1, R1, 0			;; R1 <- 0x0001
	LSHF R2, R1, 1			;; R2 <- 0x0002
	LSHF R3, R2, 2			;; R3 <- 0x0008
	LSHF R4, R3, 3			;; R4 <- 0x0040
	LSHF R5, R4, 4			;; R5 <- 0x0400
	LSHF R6, R5, 5			;; R6 <- 0x8000

HALT_PROG:
	BRnzp HALT_PROG

SEGMENT
DATA:
LSHF_TVAL:		DATA2 4x0001 ;; Arg for testing LSHF
RSHFL_TVAL: 	DATA2 4xFFFF ;; Arg for testing RSHFL
RSHFA_TVAL: 	DATA2 4x8000 ;; Arg for testing RSHFA




