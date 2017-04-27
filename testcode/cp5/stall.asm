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

	LEA R0, DATA

  ;Testing LDB
	LDR R1, R0, 0
	ADD R2, R1, R1


HALT_PROG:
	BRnzp HALT_PROG


SEGMENT
DATA:
TVAL_1: 		DATA2 4x0001 ;; Args for testing LDB and STB
TVAL_2: 		DATA2 4x0200 ;; Args for testing LDB and STB
TVAL_3: 		DATA2 4x0003 ;; Args for testing LDB and STB
TVAL_4: 		DATA2 4x0400 ;; Args for testing LDB and STB
TVAL_5: 		DATA2 4x0005 ;; Args for testing LDB and STB
TVAL_6: 		DATA2 4x0600 ;; Args for testing LDB and STB
TVAL_7: 		DATA2 4x0007 ;; Args for testing LDB and STB
