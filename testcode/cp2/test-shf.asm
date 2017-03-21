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

	;; Load values into registers
	LDR R1, R0, RSHFL_TVAL
	NOP
	NOP
	NOP
	NOP
	NOP
	LDR R2, R0, RSHFL_TVAL
	NOP
	NOP
	NOP
	NOP
	NOP
	LDR R3, R0, RSHFL_TVAL
	NOP
	NOP
	NOP
	NOP
	NOP
	LDR R4, R0, RSHFL_TVAL
	NOP
	NOP
	NOP
	NOP
	NOP
	LDR R5, R0, RSHFL_TVAL
	NOP
	NOP
	NOP
	NOP
	NOP
	LDR R6, R0, RSHFL_TVAL
	NOP
	NOP
	NOP
	NOP
	NOP
	LDR R7, R0, RSHFL_TVAL
	NOP
	NOP
	NOP
	NOP
	NOP

	;; Testing RSHFL
	RSHFL R1, R1, 15		;; R1 <- 0x0001
	NOP
	NOP
	NOP
	NOP
	NOP
	RSHFL R2, R2, 14		;; R2 <- 0x0003
	NOP
	NOP
	NOP
	NOP
	NOP
	RSHFL R3, R3, 13		;; R3 <- 0x0007
	NOP
	NOP
	NOP
	NOP
	NOP
	RSHFL R4, R4, 12		;; R4 <- 0x000F
	NOP
	NOP
	NOP
	NOP
	NOP
	RSHFL R5, R5, 11		;; R5 <- 0x001F
	NOP
	NOP
	NOP
	NOP
	NOP
	RSHFL R6, R6, 10		;; R6 <- 0x003F
	NOP
	NOP
	NOP
	NOP
	NOP
	RSHFL R7, R7, 9			;; R7 <- 0x007F
	NOP
	NOP
	NOP
	NOP
	NOP

	;; Testing RSHFA
	LDR R4, R0, RSHFA_TVAL
	NOP
	NOP
	NOP
	NOP
	NOP
	RSHFA R3, R4, 8			;; R3 <-0xFF80
	NOP
	NOP
	NOP
	NOP
	NOP
	RSHFA R2, R3, 7			;; R2 <-0xFFFF
	NOP
	NOP
	NOP
	NOP
	NOP
	LDR R2, R0, RSHFA_TVAL
	NOP
	NOP
	NOP
	NOP
	NOP
	RSHFA R1, R2, 6			;; R1 <-0xFE00
	NOP
	NOP
	NOP
	NOP
	NOP

	;; Testing LSHF
	LDR R1, R0, LSHF_TVAL
	NOP
	NOP
	NOP
	NOP
	NOP
	LSHF R1, R1, 0			;; R1 <- 0x0001
	NOP
	NOP
	NOP
	NOP
	NOP
	LSHF R2, R1, 1			;; R2 <- 0x0002
	NOP
	NOP
	NOP
	NOP
	NOP
	LSHF R3, R2, 2			;; R3 <- 0x0008
	NOP
	NOP
	NOP
	NOP
	NOP
	LSHF R4, R3, 3			;; R4 <- 0x0040
	NOP
	NOP
	NOP
	NOP
	NOP
	LSHF R5, R4, 4			;; R5 <- 0x0400
	NOP
	NOP
	NOP
	NOP
	NOP
	LSHF R6, R5, 5			;; R6 <- 0x8000
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
LSHF_TVAL:		DATA2 4x0001 ;; Arg for testing LSHF
RSHFL_TVAL: 	DATA2 4xFFFF ;; Arg for testing RSHFL
RSHFA_TVAL: 	DATA2 4x8000 ;; Arg for testing RSHFA




