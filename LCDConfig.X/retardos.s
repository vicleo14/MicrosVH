        .include "p30F4013.inc"

        .global _RETARDO1S
        .global _RETARDO15ms
  
;/**@brief ESTA RUTINA GENERA UN RETARDO DE 1 SEG APROX
; */
_RETARDO1S:
	PUSH	W0  ; PUSH.D W0
	PUSH	W1
	
	MOV	#10,	    W1
CICLO2_1S:
    
	CLR	W0	
CICLO1_1S:	
	DEC	W0,	    W0
	BRA	NZ,	    CICLO1_1S	
    
	DEC	W1,	    W1
	BRA	NZ,	    CICLO2_1S
	
	POP	W1  ; POP.D W0
	POP	W0
	RETURN

;/**@brief ESTA RUTINA GENERA UN RETARDO DE 1 SEG APROX
; */
_RETARDO15ms:
    PUSH W0
    MOV #0X6BE9, W0
    ;MOV #0XFFFF, W0
    ;MOV #0X2, W0
    
    RETARDOA:
    DEC W0,W0
    BRA NZ,RETARDOA
    
    POP W0
   return
  RETURN


