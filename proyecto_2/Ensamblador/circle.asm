switch:
    movi r2, 20         ; busco el valor seteado en r1
    movi r0, 1   
    crg r1, r2
    cmp r1, r0          ; si es igual a 1 inicia el programa
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

    movi r0, 24         ; referencia en mem para add 24 --> dataOUT[0]
    movi r2, 0
    sum r2, r2, r0      ; direccion relativa a la memoria de salida[24-10024]
    movi r0, 0
    crg r9, r0          ; direccion en mem para color blanco

;---------------------------Imagen en Blanco---------------------------
loop_y:
    cmp r3, r12
    sig endWhite
    movi r1, 0
    sum r3, r3, r4

loop_x:
    cmp r1, r13
    sig loop_y
    esc r2, r9          ; escribir pixel blanco a memoria
    sali update
    
update:
    sum r1, r1, r4      ; actualizar contador x
    sum r2, r2, r4      ; actualizar direccion 
    sali loop_x

endWhite: 
    res r2, r2, r4      ; ultimo pixel
    esc r2, r9
    movi r0, 0

;---------------------------Generar circulo---------------------------

init_circle:
    movi r0, 24             ; referencia en mem para add 24 --> dataOUT[0]
    res r2, r2, r2          ; reset a 0
    sum r2, r2, r0          ; direccion relativa a la memoria de salida[24-10024]
    res r3, r3, r3          ; reset a 0 y limit < = 100
    res r1, r1, r1          ; reset a 0 x limit < = 100
    movi r7, 625            ; radio = 25, radio*radio = 625
    movi r11, 50            ; centro (x_c, y_c) 50, 50
    movi r0, 10             ; direccion en mem para color morado
    crg r6, r0              ; r6 tiene el valor 808000    


circle_y:
    cmp r3, r12
    sig end_circle
    movi r1, 0
    sum r3, r3, r4
    out r6


; r5 es y_values = y - y_c luego r5 dy^2
; r8 x_values = x - x_c     luego r8 dx^2
; r10 es distance 
; r6 tiene el color para circulo
; r12 y r13 no se tocan tienen las dimensiones de la imagen
circle_x:
    cmp r1, r13
    sig circle_y
    ; obtener y_values = y - y_c
    res r5, r3, r11

    ; obtener x_values = x - x_c
    res r8, r1, r11

    ; dy^2 = y_values*y_values 
    mul r5, r5, r5

    ; dx^2 = x_values*x_values
    mul r8, r8, r8

    ; dx^2 + dy^2 = distance
    sum r10, r8, r5

    ; distance < radio, salto siempre que sea menor
    cmp r10, r7
    slm isCircle
    sali update_addr ; siempre salto para actualizar x y mem addr

isCircle:
    esc r2, r6          ; escribir pixel
    sali update_addr

update_addr:
    crg r0, r2
    sum r1, r1, r4

    sum r2, r2, r4      ; actualizar direccion 
    out r0
    sali circle_x

end_circle:
    movi r0, 0
    movi r5, 0
    movi r6, 0
    movi r7, 0
    movi r8, 0
    movi r10, 0

