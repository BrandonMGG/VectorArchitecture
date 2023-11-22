;Scalar instruction. Guardar el valor de 100(q representa una direccion de la mem de datos) en el registro R0
movi R0, 100 ; 0010_0000_0000000001100100

; Scalar instruction. Guardar el contenido de la direccion en R0, en el registro R1
crg R1, R0 ; 0111_0001_0000_xxxxxxxx

;Vectorial instruction. Hacer un copy del valor que guarda R1, en el vector VR0. Esto se tiene que hacer en las 8 posiciones del vector.
vmov VR0[0], R1 
vmov VR0[1], R1
vmov VR0[2], R1
vmov VR0[3], R1
vmov VR0[4], R1
vmov VR0[5], R1
vmov VR0[6], R1
vmov VR0[7], R1


; ------------- HACER LO MISMO QUE SE HIZO ARRIBA ---------

;Scalar instruction. Guardar el valor de 101(q representa una direccion de la mem de datos) en el registro R2
movi R2, 101

; Scalar instruction. Guardar el contenido de la direccion en R2, en el registro R3
crg R3, R2

;Vectorial instruction. Hacer un copy del valor que guarda R1, en el vector VR0. Esto se tiene que hacer en las 8 posiciones del vector.
vmov VR1[0], R3
vmov VR1[1], R3
vmov VR1[2], R3
vmov VR1[3], R3
vmov VR1[4], R3
vmov VR1[5], R3
vmov VR1[6], R3
vmov VR1[7], R3

; SUMAR LO VALORES Y GUARDARLOS EN EL VECTOR VR3
vsum VR3, VR0, VR1


; pruebas vectoriales
vsum vr15, vr0, vr15
vres vr15, vr0, vr15
vmul vr15, vr0, vr15
vand vr15, vr0, vr15
vcmplt vr15, vr0, vr15
vmov vr15[6], r0
vmovf vr15, vr0

vcrg vr15, vr0
vesc vr15, vr1