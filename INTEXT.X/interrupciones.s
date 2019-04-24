 .include "p30F4013.inc"
 .GLOBAL __INT0Interrupt
 .GLOBAL _uni
 .GLOBAL _dece
 .GLOBAL _cen
 .GLOBAL _umi
 
 __INT0Interrupt:
    push w0
    push w1
    MOV #10,	W0
    INC.B _uni
    CP.B _uni
    BRA	NZ, fin
    CLR.B _uni
    INC.B _dece
    CP.B _dece
    BRA	NZ, fin
    CLR.B _dece
    INC.B _cen
    CP.B _cen
    BRA	NZ, fin
    CLR.B _cen
    INC.B _umi
    CP.B _umi
    BRA	NZ, fin
    CLR.B _umi
    fin:
    BCLR IFS0,	#INT0IF
    pop w0
    pop w1
    retfie


