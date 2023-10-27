with open("binary.txt", "r") as f:
    with open('nuevo_archivo_binario.txt', 'w') as f2:
        for linea in f:
            binario = linea.strip() #eliminamos el salto de línea
            hexadecimal = hex(int(binario, 2))[2:].zfill(8) #convertimos a hexadecimal y agregamos ceros a la izquierda si es necesario
            print(hexadecimal) #imprimimos el resultado
            f2.write(hexadecimal + '\n')  # Escribir el valor hexadecimal en el nuevo archivo de texto
