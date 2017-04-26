; =========================
; Schrittmotor - Seven Segment Cont-Down
; =========================
	JMP	Start
; Datenbereich
	DB	FA	
	DB	DF
	DB	FF	
	DB	8B
	DB	FD
	DB	DD
	DB	4F
	DB	9F
	DB	B7
	DB	0B
	DB	FB

Start:
	MOV	BL,02	; 02 ist Startadresse des Datenbereichs
Rep1:
	MOV	AL,[BL]	; Kopiere Daten vom Datenbereich nach AL
	OUT	02		; Wert von AL nach Port 01 ausgeben

	CMP	AL,FB	; ist der letzte Datenbereich erreicht
	JZ	Blink	; wenn ja, springe zu Blink
	INC	BL		; wenn nein, setzte Zeiger in BL auf nächsten Datenbereich
	JMP	Rep1
	
	
Blink:
	MOV	CL,5
Rep2:
	MOV	AL,0
	OUT	02
	MOV	AL,1
	OUT	02
	MOV	AL,FA
	OUT	02
	MOV	AL,FB
	OUT	02
	DEC	CL		; Subtrahiere 1 von CL
	JNZ	Rep2	; zurück zu Rep2 wenn CL nicht = 0
	JMP	Start	; sonst zurück zum Start
	END

