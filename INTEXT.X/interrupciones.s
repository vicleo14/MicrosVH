 .include "p30F4013.inc"
 .GLOBAL __INT0Interrupt
 .GLOBAL _uni
 .GLOBAL _dece
 .GLOBAL _cen
 .GLOBAL _umi
 
 __INT0Interrupt:
    push w0
    INC.B _uni
    MOV #10,	W0
    CP.B _uni
    BRA	NZ, fin
    
    INC.B _dece
    MOV #10,	W0
    CP.B _dece
    BRA	NZ, fin
    
    INC.B _cen
    MOV #10,	W0
    CP.B _cen
    BRA	NZ, fin
    
    INC.B _umi
    MOV #10,	W0
    CP.B _umi
    BRA	NZ, fin
    
    
    
    fin:
    BCLR ifs0,	#int0if
    pop w0
    retfie


