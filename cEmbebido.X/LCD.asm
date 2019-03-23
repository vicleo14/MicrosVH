    .include "p30F4013.inc"
    
    .GLOBAL _funcion1
    .GLOBAL _funcion2
    .GLOBAL _funcion3
    .GLOBAL _funcion4
    .GLOBAL _var
    .GLOBAL _comandoLCD
    .GLOBAL _datoLCD
    .GLOBAL _busyFlagLCD
    .GLOBAL _initLCD8bits
    
    .EQU RS_LCD,RF2
    .EQU RW_LCD,RF3
    .EQU E_LCD,RF3
 
 _comandoLCD:
    BCLR PORTF,#RS_LCD
    NOP
    BCLR    PORTF,#RW_LCD
    NOP
    BSET    PORTD,#E_LCD
    NOP
    MOV.B	WREG, PORTB
    NOP
    BCLR PORTD,#E_LED
    NOP
    
    return
_datoLCD:
    BSET PORTF,#RS_LCD
    NOP
    BCLR    PORTF,#RW_LCD
    NOP
    BSET    PORTD,#E_LCD
    NOP
    MOV.B	WREG, PORTB
    NOP
    BCLR PORTD,#E_LED
    NOP
    
    return
    
_busyFlagLCD:
    ;IMPLEMENTAR
    BCLR PORTF,#RS_LCD
    NOP
    
    return
_initLCD8bits:
    CALL RETARDO_15ms
    MOV #0X30, W0
    CALL _comandoLCD
    
    CALL RETARDO_15ms
    MOV #0X30, W0
    CALL _comandoLCD
    
    CALL RETARDO_15ms
    MOV #0X30, W0
    CALL _comandoLCD
    
    CALL RETARDO_15ms
    MOV #0X38, W0
    CALL _comandoLCD
    ;CONTINUARA
    return
    
    
    
 _funcion1:
    push w0
    mov #3,W0
    mov w0,_var
    pop w0
    return
 _funcion2:
    push w1
    push w0
    mov #12,w0
    mov #3,w1
    add w0,w1,w0
    pop w0
    pop w1
    return
    
_funcion3:
    add w0,w1,w0
    return
    
_funcion4:
    push w1
    clr w2
    ciclo:
    mov.b [w0++],w1
    cp0.b w1
    bra z,fin
    inc w2,w2
    goto ciclo
    
fin:
    mov w2,w0
    pop w1
    return


