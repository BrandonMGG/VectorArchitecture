switch:
    movi r2, 1         ; busco el valor seteado en r1
    movi r0, 1   
    movi r10, 0        ; increment
    movi r11, 10       ; limit
    cmp r2, r0          ; si es igual a 1 inicia el programa
    sig start        
    sali switch
;Probar las instrucciones basicas de la micro-arquitectura
start: 
    movi r0, 300         ; direccion en lut para valor 90 000
    crg r1, r0          ; r1 tiene el valor 90 000
    out r1

    movi r0, 301         ; direccion en lut para valor 180 000
    crg r2, r0          ; r2 tiene el valor 180 000
    out r2

    movi r0, 12          
    crg r3, r0          ; r3 tiene el valor = sine_lut[12] = 80
    out r3
;------------acceso a memoria sen(x), escritura en mem4
    movi r0, 302       
    sum r4, r1, r0      ; ya estoy ubicado en 90 302
    esc r4, r3

    crg r5, r4
    out r5

    movi r0, 13          
    crg r3, r0          ; r3 tiene el valor = sine_lut[13] 
    out r3

    movi r0, 303       
    sum r4, r1, r0      ; ya estoy ubicado en 90 303
    esc r4, r3

    crg r5, r4
    out r5

    movi r0, 14          
    crg r3, r0          ; r3 tiene el valor = sine_lut[14]
    out r3

    movi r0, 304       
    sum r4, r1, r0      ; ya estoy ubicado en 90 304
    esc r4, r3

    crg r5, r4
    out r5

    movi r0, 15          
    crg r3, r0          ; r3 tiene el valor = sine_lut[15] = 80
    out r3

    movi r0, 305       
    sum r4, r1, r0      ; ya estoy ubicado en 90 305
    esc r4, r3

    crg r5, r4
    out r5
