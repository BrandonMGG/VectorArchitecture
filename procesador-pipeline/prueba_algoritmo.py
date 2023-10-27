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
            seno.append(r)

with open("pixel.txt", "r") as f1: 
        for line in f1:
            hex_value = line.strip()  # Eliminar caracteres en blanco y saltos de línea
            e = int(hex_value, 16)  # Obtener el componente rojo
            pixel.append(e)

            
for y in range(300):
    for x in range(300):
        x_aux = x+int(5*seno[y]/10000)
        y_aux = y+int(5*seno[x]/10000)
        if (x_aux*y_aux)< 90000:
            pixel_nuevo[x_aux*y_aux] = pixel[x*y]

imagen = Image.new("L", (300, 300))

# Asignar los valores de píxeles a la imagen
imagen.putdata(pixel_nuevo)

# Guardar la imagen en un archivo
imagen.save("imagen_resultante.png")
