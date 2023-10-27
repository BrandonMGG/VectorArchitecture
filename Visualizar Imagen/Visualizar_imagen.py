from PIL import Image
import numpy as np


# También puedes guardar la línea completa en un nuevo archivo de texto
with open("nuevo_archivo.txt", "w") as f1:

    with open("pixels.txt", "r") as f:
        pixel_data = []
        for line in f:
            hex_value = line.strip()  # Eliminar caracteres en blanco y saltos de línea
            if hex_value == "xxxxxxxx":
                f1.write("0")
            else:
                r = int(hex_value, 16)  # Obtener el componente rojo
                #print(r)
                aux= str(r)
                f1.write(aux)
            f1.write(" ")



with open('nuevo_archivo.txt') as f:               #abrir los pixeles que contiene el txt
    contenido = f.readlines()

pixeles = np.loadtxt(contenido, dtype=np.uint8)
pixeles = np.resize(pixeles, (300, 300))                #tamano de la imagen
imagen = Image.fromarray(pixeles)
imagen.show() 
