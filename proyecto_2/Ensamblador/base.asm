switch:
    movi r2, 1         ; busco el valor seteado en r1
    movi r0, 1   
    cmp r2, r0          ; si es igual a 1 inicia el programa
    sig start        
    sali switch
;Probar las instrucciones basicas de la micro-arquitectura
start: 
    movi r3, 0      ; y
    movi r1, 0      ; x
    movi r12, 300   ; height
    movi r13, 300   ; width
    movi r4, 1      ; increment

    movi r0, 300             ; referencia en lut para valor 90 000 
    crg r2, r0              ; tiene valor 90 000 inicialmente guardado en direccion 300 
    movi r0, 302
    sum r2, r2, r0      ; direccion relativa a la memoria de salida[90302-180301]
    movi r0, 0        ; direccion en lut para valor white
    crg r6, r0          ; r6 tiene el valor FF FF FF    

;---------------------------Imagen en blanco---------------------------
loop_y:
    cmp r3, r12
    sig end
    sum r3, r4

loop_x:
    cmp r1, r13
    sig loop_y
    sum r1, r4

    esc r2, r6          ; escribir pixel
    crg r5, r2

    out r5
    movi r0, 1
    sum r2, r2, r0      ; actualizar direccion
    sali loop_x

end: 
    movi r0, 0
    movi r1, 0
    movi r2, 0
    movi r3, 0
    movi r4, 0