ORG 0

Main:
	LOADI 1
	OUT   LEDs
	CALL  WasteTime
	LOADI 0
	OUT   LEDs
	CALL  WasteTime
	JUMP  Main

WasteTime:
    LOADI 0
	;; wastes about 200,000 clock cycles out of 1.67 mil necessary
	;; 25 instructions * 2^16 ~= 1.67 mil
WasteLoop:
    ADDI  1
	;; 22 nops
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
    JZERO WasteDone
    JUMP  WasteLoop
WasteDone:
	RETURN




LEDs:      EQU &H001