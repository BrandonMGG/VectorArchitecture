from PIL import Image
import numpy as np
with open('imagen_leon.txt') as f:               #abrir los pixeles que contiene el txt
    contenido = f.readlines()

pixeles = np.loadtxt(contenido, dtype=np.uint8)
pixeles = np.resize(pixeles, (300, 300))                #tamano de la imagen
imagen = Image.fromarray(pixeles)
imagen.show() 
