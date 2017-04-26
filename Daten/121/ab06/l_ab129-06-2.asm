; =========================
; Ampelsteuerung
; =========================
	JMP	Start
; Datenbereich
	DB	90			; rot - rot
	DB	98			; rot - rot/orange
	DB	84			; rot - gr�n
	DB	8C			; rot - gr�n/orange
	DB	90			; rot - rot
	DB	D0			; rot/orange - rot
	DB	30			; gr�n - rot
	DB	70			; gr�n/orange - rot

; =========================
; Programmstart 
Start:
	MOV	BL,2		; Start des Datenbereichs in BL
Rep1:
	MOV	AL,[BL]		; Wert von Adresse BL in AL
	OUT	01			; Ausgabe von AL an Port 01
	CMP	AL,70		; IF AL = 70			Datenbereich fertig
	JZ	Start		; THEN GOTO Start
	INC	BL			; BL = BL + 1		
	CMP	AL,84		; IF AL = 84			Ampel auf rot - gr�n
	JZ	SleepMittel ; THEN GOTO SleepMittel
	CMP	AL,30		; IF AL = 30			Ampel auf gr�n - rot
	JZ	SleepLang	; THEN GOTO SleepLang
	
	JMP	Rep1		; GOTO Rep1	

; Vorbereitung f�r mittleres Warten
SleepMittel:		
	MOV	CL,5		; Wartezeit in CL
	CALL	40		; Aufruf Prozedur Sleep
	JMP	Rep1		; GOTO Rep1	

; Vorbereitung f�r langes Warten
SleepLang:
	MOV	CL,10		; Wartezeit in CL
	CALL	40		; Aufruf Prozedur Sleep
	JMP	Rep1		; GOTO Rep1

; -------------------------
; Start Prozedur Sleep 
	ORG 	40		; Festlegen des Prozedurstarts im Speicher
	PUSHF			; CPU-Flags sichern
Sleep:	
	DEC	CL			; CL = CL - 1
	JNZ	Sleep		; Wiederholung cbis CL = 0
	POPF			; CPU-Flags zur�cksichern
	RET				; Zur�ck nach Aufrufort
; Ende Prozedur Sleep 
; -------------------------

	END		; Programm Ende
; Programm Ende 
; =========================
