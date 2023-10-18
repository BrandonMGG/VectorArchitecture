from PIL import Image

# Dimensiones de la imagen
width = 640
height = 480

# Crear una imagen en blanco
image = Image.new("RGB", (width, height))

# Leer los píxeles desde el archivo de texto
with open("pixels.txt", "r") as file:
    for y in range(height):
        for x in range(width):
            # Leer los valores RGB de una línea del archivo
            line = file.readline()
            r, g, b = map(int, line.strip().split())

            # Establecer el color del píxel en la imagen
            image.putpixel((x, y), (r, g, b))

# Mostrar la imagen
image.show()

# Guardar la imagen en un archivo (opcional)
image.save("output_image.png")
