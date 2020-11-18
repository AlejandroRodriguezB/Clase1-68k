;===========================================================
;SYSTEM CODE
;===========================================================

;-----------------------------------------------------------
SYSINIT
; INITIALIZE SYSTEM, INSTALL TRAP AND SWITCH TO USER MODE.
; INPUT     : NONE
; OUTPUT    : NONE
; MODIFIERS : NONE
;-----------------------------------------------------------
    MOVE.W SR,-(A7)                     ;Pasamos a modo usuario
    AND.W #$DFFF,(A7)                   ;MASK copy of Sr
    MOVEM.L A0-A1/D0-D2,-(A7)
    LEA     .DATA,A1
    MOVE.W  #3,D2
    MOVE.B  #32,D0
.LOOP       
    MOVE.B  (A1)+,D1
    TRAP    #15
    MOVE.L  D1,(A0)+
    DBRA.W  D2,.LOOP
    MOVE.L #SYSISRTR,($80+SYSTRPNM*4)   ;INSTALL TRAP
    MOVEM.L (A7)+,A0-A1/D0-D2
    RTE


.DATA       DC.B    1,2,3,7,0           ; TRAP #15 FUNCTION 32 PARAMETERS
            DS.W    0

;-----------------------------------------------------------
SYSISRTR
; TRAP SERVICE ROUTINE
; INPUT     :   D0.B = 0 SHOW HARDWARE WINDOW
;               D0.B = 1 WRITE D1.B INTO LED
;               D0.B = 2 WRITE HEW DIGIT D1.B INTO DISPLAY D2.B
; OUTPUT    : NONE
; MODIFIERS : NONE
;-----------------------------------------------------------

            LEA .JTABLE,A0  
            AND.L #$FF,D0       ;mask D0
            ASL.W #2,D0         ;D0=D0*4
            MOVE.L (A0,D0),A0   ;get jump adress
            JMP (A0)

; --- task 0 -----------------------------------------------
.TASK0
    MOVE.B  #32, D0
    CLR.B   D1
    TRAP    #15
    BRA .END
    
; --- task 1 -----------------------------------------------

.TASK1
    MOVE.L (SYSLEDAD),A0
    MOVE.B D1,(A0)
    BRA .END
    
; --- task 2 -----------------------------------------------
.TASK2
    
    AND.L $#FF,D2
    ASL.W #1,D2
    MOVE.L (SYSSEGAD),A0
    AND.L $#FF,D1           ;mask D1
    LEA .DATA2,A1           ;symbol vector address
   
    MOVE.B (A1,D1),(A0,D2) ;write data
.END
    RTE
    
.JTABLE DC.L    .TASK0,.TASK1,.TASK2

.DATA2      DC.B    $3F,$06,$5B,$4F,$66,$6D,$7D,$07,$7F,$6F,$77,$7C,$39,$5E,$79
            DC.B    $71
            DS.W 0
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
