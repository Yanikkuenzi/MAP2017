; ===== CONTROL THE TRAFFIC LIGHTS =============================

	CLO		; Close unwanted windows.
	JMP Start

	DB 90
	DB 98
	DB 84
	DB 8C
	DB 90
	DB D0
	DB 30
	DB 70
	
Start:
	; Turn off all the traffic lights.
	MOV BL, 02 ; Set BL 02 (Start of data table)
	
Rep:
	MOV AL, [BL]; Move the content of BL to AL
	OUT 01
	CMP AL, 70 ; Check if its the last entry of the datatable
	JZ Start ; If the Z-Flag is set (result of comparison), jump to start
	CMP AL, 84 ; Check if state is red / green
	JZ Longdelay ; If the state is red / green make a long delay
	JMP Else ; Jump to the else mark

Longdelay:	
	MOV CL, 20 ; Store the delay in the CL register
	CALL 60 ; Call the delay procedure
	JMP Continue ; Jump to the Continue mark

Middlelongdelay:
	MOV CL, 10 ; Store the delay in the CL register
	CALL 60 ; Call the delay procedure
	JMP Continue ; Jump to the Continue mark

Else:
	CMP AL, 30
	JZ Middlelongdelay ; Delay a little if the state is red / green

Continue:
	INC BL ; Increment BL
	JMP Rep ; Jump back to repeat


;; 	PROCEDURE
	ORG 60 ; Generate machine code from address [30]

	PUSH CL ; Save AL on the stack
	PUSHF	; Save the CPU flags on the stack
Redo:
	DEC CL ; Decrement AL
	JNZ Redo ; Jump to the mark Redo if AL is not zero
	
	POPF ; Restore the CPU Flags from the stack
	POP CL ; Restore the AL Register from the stack
	
	RET ; Return from the procedure
	END		; Program ends.
	
; ===== Program Ends ==========================================

	YOUR TASK
	=========
	Use the help page on Hexadecimal and ASCII codes.
	Work out what hexadecimal numbers will activate the
	correct traffic lights. Modify the program to step
	the lights through a realistic sequence.
