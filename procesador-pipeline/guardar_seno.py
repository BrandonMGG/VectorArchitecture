# Importamos la librería math para usar funciones matemáticas
import math

# Definimos la fórmula a utilizar (en este caso, la función seno)
def mi_formula(x):
    return math.sin((2*math.pi*x)/75)*10000

# Definimos el rango de valores para evaluar la fórmula
inicio = 1
fin = 300
paso = 1

# Creamos el archivo de texto donde se guardarán los resultados
nombre_archivo = "resultados.txt"
archivo = open(nombre_archivo, "w")

# Iteramos sobre los valores en el rango especificado
x = inicio
while x <= fin:
    # Evaluamos la fórmula en el valor actual de x
    resultado = int(mi_formula(x))
    resultadofinal = hex(abs(resultado))[2:].zfill(8)
    # Guardamos el resultado en el archivo de texto
    archivo.write(str(resultadofinal) + "\n")
    
    # Incrementamos el valor de x para la siguiente iteración
    x += paso

# Cerramos el archivo de texto
archivo.close()

print("Los resultados se han guardado en el archivo " + nombre_archivo)
