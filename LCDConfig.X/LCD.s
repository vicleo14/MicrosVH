        .include "p30F4013.inc"

        .global _datoLCD
	.global _comandoLCD
	.global _busyFlag
	.global _iniLCD8bits
 
	.EQU RS_LCD,RF2
	.EQU RW_LCD,RF3
	.EQU E_LCD,RD2
	;.EQU	BF_LCD,	    RB7; NO SE PARA QUE ES
;/**@brief ESTA RUTINA MANDA UN DATO A UN LCD
; */
_datoLCD:
    PUSH w1
    ;MUEVO EL APUNTADOR DE W0 A W2
   
    CICLO_DATO:
    CALL    _RETARDO15ms
    mov.b [w0++],w1
    
    
    CP0.b w1
    BRA z,fin
    
    
    PUSH W0
    MOV W1,W0
    
    
    BSET PORTF,#RS_LCD
    NOP
    BCLR    PORTF,#RW_LCD
    NOP
    BSET    PORTD,#E_LCD
    NOP
    ;Se mueve al puerto el valor del reg
    MOV.B	WREG, PORTB
    NOP
    BCLR PORTD,#E_LCD
    NOP
    POP W0
 
    
    GOTO CICLO_DATO
    
fin:
   POP w1
   RETURN
;/**@brief ESTA RUTINA MANDA UN COMANDO A UN LCD
; */
_comandoLCD:
    BCLR PORTF,#RS_LCD
    NOP
    BCLR    PORTF,#RW_LCD
    NOP
    BSET    PORTD,#E_LCD
    NOP
    MOV.B	WREG, PORTB
    NOP
    BCLR PORTD,#E_LCD
    NOP
    return
;/**@brief ESTA RUTINA VERIFICA LA BANDERA BUSY FLAG DEL LCD
; */
_busyFlag:
    PUSH W1
    PUSH W2
    
    BCLR PORTF,	#RS_LCD
    NOP
    
    ;OR EN TRISB CON 0x00FF
    MOV #0XFF,W1
    MOV W1,TRISB
    NOP
    BSET PORTF, #RW_LCD
    NOP
    BSET PORTD, #E_LCD
    NOP
   OCUPADO:
    BTSC PORTB, #RB7;SALTA SI ES CLEAR
    GOTO OCUPADO
    NOP
    BCLR PORTD,#E_LCD
    NOP
    BCLR PORTF,#RW_LCD
    NOP
    ;AND TRISB & 0X00FF
    MOV #0XFF00,W1
    MOV TRISB,W2
    AND W2,W1,W1
    MOV W1,TRISB
    NOP
    
    POP W2
    POP W1
    RETURN
   
    
;/**@brief ESTA RUTINA VERIFICA LA BANDERA BUSY FLAG DEL LCD
; */
_iniLCD8bits:
    CALL    _RETARDO15ms
    MOV	    #0X30,	W0
    CALL    _comandoLCD
    
    CALL    _RETARDO15ms
    MOV	    #0X30,	W0
    CALL    _comandoLCD
    
    CALL    _RETARDO15ms
    MOV	    #0X30,	W0
    CALL    _comandoLCD

    CALL    _busyFlag
    MOV	    #0X38,	W0
    CALL    _comandoLCD
   
    CALL _busyFlag
    MOV #0X08, W0
    CALL _comandoLCD 
    
    CALL _busyFlag
    MOV #0X01, W0
    CALL _comandoLCD 
    
    CALL _busyFlag
    MOV #0X06, W0
    CALL _comandoLCD 
    
    ;CALL _busyFlag
    CALL _RETARDO15ms
    MOV #0X0F, W0
    CALL _comandoLCD
    
    return



