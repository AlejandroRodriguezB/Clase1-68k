*-----------------------------------------------------------
* Title      :
* Written by :Alejandro Rodriguez Bañón
* Date       :18/11/20
* Description:
*-----------------------------------------------------------
    ORG    $1000
; --- CONSTANTS-----------------------------------------    
    INCLUDE "SYSCONST.X68"
    INCLUDE "SYSTEM.X68"
    
    
; --- MAIN PROGRAM -----------------------------------------
START:                  
    JSR SYSINIT
    

; --- END OF SIMULATION -----------------------------------
    SIMHALT             ; halt simulator

; VARIABLE DECLARATIONS ------------------------------------
    INCLUDE "SYSVAR.X68"

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
