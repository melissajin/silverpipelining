ORIGIN 4x0000

SEGMENT CodeSegment:
  LEA R0, DataSegment
  LDR R1, R0, LOC1
  BRnzp CONT ; Taken (shows flush on mispredict)
  STR R1, R0, LOC2
  NOT R1, R2
  NOP
  NOP
CONT:
  LDR R1, R0, LOC2
  BRn DONE ; Not taken (shows correctly predicted branch)
  ADD R1, R1, R0
  NOT R1, R1
  ADD R1, R1, 1
  LDR R2, R0, LOC4
DONE: ; Load all performance counter values
  LDI R7, R0, COUNTER0 ; L2 hits
  LDI R6, R0, COUNTER1 ; L2 misses
  LDI R5, R0, COUNTER2 ; DL1 hits
  LDI R4, R0, COUNTER3 ; DL1 misses
  LDI R3, R0, COUNTER4 ; IL1 hits
  LDI R2, R0, COUNTER5 ; IL1 misses
  LDI R1, R0, COUNTER6 ; Branch predicts
  LDI R7, R0, COUNTER7 ; Branch mispredicts
  LDI R6, R0, COUNTER8 ; Stalls

  ; Clear all performance counter values
  STI R7, R0, COUNTER0 ; L2 hits
  STI R6, R0, COUNTER1 ; L2 misses
  STI R5, R0, COUNTER2 ; DL1 hits
  STI R4, R0, COUNTER3 ; DL1 misses
  STI R3, R0, COUNTER4 ; IL1 hits
  STI R2, R0, COUNTER5 ; IL1 misses
  STI R1, R0, COUNTER6 ; Branch predicts
  STI R7, R0, COUNTER7 ; Branch mispredicts
  STI R6, R0, COUNTER8 ; Stalls

  ; Load them back and verify that they have decreased (register values won't show up as zero due to memory accesses required)
  LDI R7, R0, COUNTER0 ; L2 hits
  LDI R6, R0, COUNTER1 ; L2 misses
  LDI R5, R0, COUNTER2 ; DL1 hits
  LDI R4, R0, COUNTER3 ; DL1 misses
  LDI R3, R0, COUNTER4 ; IL1 hits
  LDI R2, R0, COUNTER5 ; IL1 misses
  LDI R1, R0, COUNTER6 ; Branch predicts
  LDI R7, R0, COUNTER7 ; Branch mispredicts
  LDI R6, R0, COUNTER8 ; Stalls
HALT:
  BRnzp HALT ; Taken

SEGMENT DataSegment:
LOC1: DATA2 10
LOC2: DATA2 11
LOC3: DATA2 12
LOC4: DATA2 13
LOC5: DATA2 14
COUNTER0: DATA2 4xFFF0
COUNTER1: DATA2 4xFFEE
COUNTER2: DATA2 4xFFEC
COUNTER3: DATA2 4xFFEA
COUNTER4: DATA2 4xFFE8
COUNTER5: DATA2 4xFFE6
COUNTER6: DATA2 4xFFE4
COUNTER7: DATA2 4xFFE2
COUNTER8: DATA2 4xFFE0
