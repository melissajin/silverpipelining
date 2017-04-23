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
DONE:
  BRnzp DONE ; Taken
  BRnz CONT ; Handling multiple branches in the pipeline
  BRp CONT
  BRnzp CONT
  JMP R7

SEGMENT DataSegment:
LOC1: DATA2 10
LOC2: DATA2 11
LOC3: DATA2 12
LOC4: DATA2 13
LOC5: DATA2 14
