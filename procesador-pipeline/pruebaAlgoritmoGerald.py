from PIL import Image
import numpy as np

pixel = []
pixel_nuevo = [0] * 90000
seno = []
# También puedes guardar la línea completa en un nuevo archivo de texto
with open("seno.txt", "r") as f: 
        for line in f:
            hex_value = line.strip()  # Eliminar caracteres en blanco y saltos de línea
            r = int(hex_value, 16)  # Obtener el componente rojo
            if r >= 0x80000000:
               r = -((~r & 0xffffffff) + 1)
            seno.append(r)

with open("pixel.txt", "r") as f1: 
        for line in f1:
            hex_value = line.strip()  # Eliminar caracteres en blanco y saltos de línea
            e = int(hex_value, 16)  # Obtener el componente rojo
            pixel.append(e)

            
for y in range(300):
    for x in range(300):
        #x_aux = x+int(5*seno[y]/100000)
        #y_aux = y+int(5*seno[x]/100000)
        x_aux = x+int(5*seno[y]/10000)
        y_aux = y+int(5*seno[x]/10000)
        #x_aux = x
        #y_aux = y
        if 0 <= x_aux < 300 and 0 <= y_aux < 300:
            pixel_nuevo[y_aux*300+x_aux] = pixel[y*300+x]
        #pixel_nuevo[x_aux*y_aux] = pixel[x*y]
        
        #if (x_aux*y_aux)< 90000:
         #   print([x,y])
        #if (x_aux*y_aux)< 90000:
          #  pixel_nuevo[x_aux*y_aux] = pixel[x*y]

imagen = Image.new("L", (300, 300))

# Asignar los valores de píxeles a la imagen
imagen.putdata(pixel_nuevo)

# Guardar la imagen en un archivo
imagen.save("imagen_resultante.png")
