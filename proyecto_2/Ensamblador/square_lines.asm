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


;---------------------------Generar cuadrado---------------------------

init_square:
    movi r0, 2449           ; referencia en mem para add en la coordenada (25,25) 2449 = 100x24 + 25 + offset[24]

    res r2, r2, r2          ; reset a 0
    sum r2, r2, r0          ; direccion relativa a la memoria de salida[24-10024]
    res r3, r3, r3          ; reset a 0 y limit < = 100
    res r1, r1, r1          ; reset a 0 x limit < = 100

    movi r0, 25            ; esquina (x_o, y_o) 25, 25
    sum r3, r3, r0         ; set y = 25 y, limit < = 100
    sum r1, r1, r0         ; set x = 25 x, limit < = 100
    movi r11, 50          ; para moverse en el cuadrado
    movi r7, 76            ; esquina  + lado = 25 + 50  
    
    movi r0, 14             ; direccion en mem para color naranja
    crg r6, r0              ; r6 tiene el valor FFA500    

square_y:
    cmp r3, r7              ; y 26
    sig end_square

primeralinea:
    movi r8, 25             ;para saber que estamos en la primera fila
    cmp r3, r8              ; vemos si estamos en la primera
    sig square_x            ; en caso de que si saltamos y dibujamos una linea con square_x
    
    esc r2, r6              ; escribimos un pixel
    sum r2, r2,r8           ; sumamos direccion actual de memoria +25
    sum r2, r2,r8           ; sumamos direccion actual de memoria +25, con esto llegamos al otro borde
    esc r2, r6              ; escribimos pixel en la inicial +50
    
    sum r3,r3,r4            ;incrementamos en 1 la fila para movernos a la siguiente 
    sum r2, r2, r11         ;sumamos 50 a la memoria para movernos los espacios en blanco
   
    movi r8, 75             
    cmp r3, r8              ; verificamos si estamos en la ultima fila de la figura
    sig square_x            ; en caso de que si hacemos raya 

    sali primeralinea       ; en caso de que no repetimos hasta terminar

square_x:
    cmp r1, r7
    sig new_address

    esc r2, r6              ; escribir pixel naranja a memoria
    sum r1, r1, r4          ; r4 es 1, es solo para incrmento
    sum r2, r2, r4
    sali square_x
    

new_address:
    movi r1, 25             ; x_0[25] reinicia contador de columna
    sum r2, r2, r11         ; nuevo address = width + address actual [2449 i = 1]
    sum r3, r3, r4
    sali square_y

square_sides:
    esc r2, r6
    

end_square:
    movi r0, 0
    movi r5, 0
    movi r6, 0
    movi r7, 0
    movi r8, 0
    movi r10, 0