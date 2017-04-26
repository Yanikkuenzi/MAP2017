; =========================
; Schrittmotor - Ganzschritte
; =========================
	JMP	Start
; Datenbereich
	DB	01			
	DB	02			
	DB	04			
	DB	08			

; =========================
; Programmstart 
Start:
	MOV	BL,2		; Start des Datenbereichs in BL
Rep1:
	MOV	AL,[BL]		; Wert von Adresse BL in AL
	OUT	05			; Ausgabe von AL an Port 01
	CMP	AL,08		; IF AL = 70			Datenbereich fertig
	JZ	Start		; THEN GOTO Start
	INC	BL			; BL = BL + 1		
	JMP	Rep1		; GOTO Rep1	


	END		
; Programm Ende 
; =========================
