ORIGIN 4x0000

SEGMENT  CodeSegment:

   LDR  R1, R0, NEGTWO  ; R1 <= -2
   LDR  R2, R0, TWO     ; R2 <= 2
   LDR  R4, R0, ONE     ; R4 <= 1







   BRnzp LOOP









ONE:    DATA2 4x0001
TWO:    DATA2 4x0002
NEGTWO: DATA2 4xFFFE
TEMP1:  DATA2 4x0001
GOOD:   DATA2 4x600D
BADD:   DATA2 4xBADD

LOOP:
   ADD R3, R1, 3       ; R3 <= R1 + 3
   AND R5, R1, 3       ; R5 <= R1 AND 3
   NOT R6, R1           ; R6 <= NOT R1







   STR R6, R0, TEMP1    ; M[TEMP1] <= R6
   LDR R7, R0, TEMP1    ; R7 <= M[TEMP1]
   ADD R1, R1, R4       ; R1 <= R1+1







   BRp DONE







   BRnzp LOOP








HALT:
   LDR  R1, R0, BADD
   BRnzp HALT








DONE:
   LDR  R1, R0, GOOD
   BRnzp DONE
