; =========================
; Ampelsteuerung
; =========================
	JMP	Start
; Datenbereich
	DB	90			; rot - rot
	DB	98			; rot - rot/orange
	DB	84			; rot - grün
	DB	8C			; rot - grün/orange
	DB	90			; rot - rot
	DB	D0			; rot/orange - rot
	DB	30			; grün - rot
	DB	70			; grün/orange - rot

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
	CMP	AL,84		; IF AL = 84			Ampel auf rot - grün
	JZ	SleepMittel ; THEN GOTO SleepMittel
	CMP	AL,30		; IF AL = 30			Ampel auf grün - rot
	JZ	SleepLang	; THEN GOTO SleepLang
	
	JMP	Rep1		; GOTO Rep1	

; Vorbereitung für mittleres Warten
SleepMittel:		
	MOV	CL,5		; Wartezeit in CL
	CALL	40		; Aufruf Prozedur Sleep
	JMP	Rep1		; GOTO Rep1	

; Vorbereitung für langes Warten
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
	POPF			; CPU-Flags zurücksichern
	RET				; Zurück nach Aufrufort
; Ende Prozedur Sleep 
; -------------------------

	END		; Programm Ende
; Programm Ende 
; =========================
