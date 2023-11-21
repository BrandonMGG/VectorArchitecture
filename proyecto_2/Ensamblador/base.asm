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
    movi r11, 50
    movi r12, 100   ; height
    movi r13, 100   ; width
    movi r4, 1      ; increment

    movi r0, 24             ; referencia en mem para add 24 --> dataOUT[0]
    movi r2, 0
    sum r2, r2, r0      ; direccion relativa a la memoria de salida[24-10024]
    movi r0, 1        ; direccion en lut para valor green
    crg r6, r0          ; r6 tiene el valor 00 FF 00   
    movi r0, 0
    crg r9, r0 

;---------------------------Imagen en verde---------------------------
loop_y:
    cmp r3, r12
    sig end
    movi r1, 0
    sum r3, r3, r4

loop_x:
    cmp r1, r13
    sig loop_y

    cmp r11, r3
    slm colorchange
    esc r2, r6          ; escribir pixel
    sali update

colorchange:
    esc r2, r9          ; escribir pixel
    sali update
    
update:
    sum r1, r1, r4
    sum r2, r2, r4      ; actualizar direccion 
    sali loop_x

end: 
    res r2, r2, r4
    esc r2, r6
    movi r0, 0

vectorial:
    vmov vr2[2], r2
    vsum vr15, vr0, vr3
    vres vr0, vr15, vr5
    vmul vr15,vr14, vr5
    vcmp vr0, vr15
    vcrg vr1, vr10
    vesc vr8, vr4
    vbrc vr1, r15
    