import re

# Diccionario de registros: mapea los nombres de los registros a sus valores correspondientes
# Los nombres de los registros están en minúsculas y van de r0 a r15
# Los valores van de 0 a 15
REGISTERS = {
    "r0": 0,
    "r1": 1,
    "r2": 2,
    "r3": 3,
    "r4": 4,
    "r5": 5,
    "r6": 6,
    "r7": 7,
    "r8": 8,
    "r9": 9,
    "r10": 10,
    "r11": 11,
    "r12": 12,
    "r13": 13,
    "r14": 14,
    "r15": 15
}

# Diccionario de instrucciones: mapea los códigos de operación (OP) de las instrucciones y sus categorías
# Los nombres de las instrucciones están en minúsculas
INSTR = {
    "nop":      {"OP": 0,   "category": "NOP"},     # NOP
    "esc":      {"OP": 1,   "category": "STW"},     # Guardar palabra
    "movi":     {"OP": 2,   "category": "MOVI"},    # Mover inmediato
    "mov":      {"OP": 3,   "category": "MOV"},     # Mover
    "out":      {"OP": 4,   "category": "OUT"},     # OUT
    "sum":      {"OP": 5,   "category": "ART"},     # Suma
    "res":      {"OP": 6,   "category": "ART"},     # Resta
    "crg":      {"OP": 7,   "category": "LDW"},     # Cargar palabra
    "mul":      {"OP": 8,   "category": "ART"},     # Multiplica
    "div":      {"OP": 9,   "category": "ART"},     # Division
    "cmp":      {"OP": 10,  "category": "CMP"},     # Comparar
    "sig":      {"OP": 11,  "category": "BI"},      # Salto si igual que a Label
    "sr":       {"OP": 12,  "category": "BR"},      # Salto a registro incondicional
    "slm":      {"OP": 13,  "category": "BI"},      # Salto si menor que a Label
    "mod":      {"OP": 14,  "category": "ART"},     # Modulo
    "sali":     {"OP": 15,  "category": "BI"}       # Salto a Label incondicional
}

# Esta función busca las etiquetas en el texto y crea un diccionario con las etiquetas y sus índices de línea correspondientes.
# Recibe como parámetro una lista de líneas de texto.
def findBranches(text):
    branches = {}
    i = 0
    while i < len(text):
        # Verifica si la línea contiene una etiqueta (identificada por el carácter ":" al final)
        if ":" in text[i]:
            # Agrega la etiqueta al diccionario branches como una clave y el índice de línea como el valor asociado
            branches[text[i][:-1]] = i
            # Elimina la línea del texto utilizando el método pop()
            text.pop(i)
        i += 1

    # Retorna el diccionario branches que contiene las etiquetas y sus respectivos índices de línea
    print(branches)
    return branches


# Esta función limpia el texto de entrada eliminando comentarios, espacios en blanco y tabulaciones.
# Recibe como parámetro el texto de entrada.
def cleanText(text):
    newText = []
    for l in text.split("\n"):
        line = l.split(";")[0]  # Elimina los comentarios, identificados por el carácter ";"
        line = line.replace("\t", " ")  # Reemplaza las tabulaciones por espacios en blanco
        line = line.strip()  # Elimina los espacios en blanco al inicio y final de la línea
        if line == "":
            continue  # Si la línea está vacía, pasa a la siguiente iteración del ciclo
        newText += [re.sub(" +", " ", line)]  # Reemplaza múltiples espacios consecutivos por un solo espacio

    return newText


# Esta función compila el código a binario y genera un archivo de salida.
# Recibe como parámetro la ruta del archivo de entrada.
def compile_code(file_path, mem_path):
    try:
        file = open(file_path)
        text = file.read()
        # Limpia el texto de entrada y lo separa en líneas
        text = cleanText(text)
        # Mapea las ramas de saltos inmediatamente
        BRANCHES = findBranches(text)

        binResult = ""
        for (i, l) in enumerate(text):
            instr = l.split(" ")[0]
            params = "".join(l.split(" ")[1:]).split(",")
            if(not INSTR.get(instr)):
                raise Exception("OP NOT RECOGNIZED LINE ({}) '{}'".format(i, l))

            result = "Instrucción actual: {1}OP{0}({0:04b})".format(
                INSTR[instr]["OP"], l.ljust(28, "."))

            category = INSTR[instr]["category"]
            # Aritmética
            if (category == "ART"):
                for r in params:
                    result += "R{0}({0:04b})".format(REGISTERS[r])
            # Salto inmediato
            elif (category == "BI"):
                result += "I{0}('0000'{0:016b})".format(int(BRANCHES[params[0]]))
            # Salto a registro
            elif (category == "BR"):
                result += "R{0}('0000'{0:04b})".format(REGISTERS[params[0]])
            # Comparar
            elif (category == "CMP"):
                result += "('0000')"
                for r in params:
                    result += "R{0}({0:04b})".format(REGISTERS[r])
            # Cargar palabra
            elif (category == "LDW"):
                for r in params:
                    result += "R{0}({0:04b})".format(REGISTERS[r])
            # Mover inmediato
            elif (category == "MOVI"):
                result += "R{0}({0:04b})".format(REGISTERS[params[0]])
                result += "I{0}({0:016b})".format(int(params[1]))
            # Guardar palabra
            elif (category == "STW"):
                result += "('0000')"
                for r in params:
                    result += "R{0}({0:04b})".format(REGISTERS[r])
            # Out
            elif (category == "OUT"):
                result += "('0000')"
                result += "R{0}({0:04b})".format(REGISTERS[params[0]])
            elif (category == "MOV"):
                for r in params:
                    result += "R{0}({0:04b})".format(REGISTERS[r])

            print(result)

            binResult += result + "\n"

        final = []  # Lista vacía para almacenar el resultado final binario
        i = 0  # Variable de índice para recorrer binResult

        while (i < len(binResult)):
            if (binResult[i] == "("):  # Si encuentra un paréntesis abierto
                i += 1
                while (binResult[i] != ")"):  # Mientras no encuentre un paréntesis cerrado
                    if (binResult[i] == "1" or binResult[i] == "0"):  # Si es un bit válido (1 o 0)
                        final.append(binResult[i])  # Agrega el bit a la lista final
                    i += 1
            if (binResult[i] == "\n"):  # Si encuentra un salto de línea
                final.append("\n")  # Agrega el salto de línea a la lista final
            i += 1

        final = "".join(final)  # Une todos los elementos de la lista final en una cadena de texto
        final = final.split("\n")  # Divide la cadena de texto en una lista de líneas
        final = [x.ljust(24, "0") for x in final]  # Añade ceros a la derecha para tener 24 bits en cada línea

        outFile = open(mem_path, "w")  # Abre el archivo de salida en modo escritura
        outFile.write("\n".join(final))  # Escribe el resultado final en el archivo
        print("¡Compilado exitosamente!")  # Imprime un mensaje indicando que la compilación se realizó exitosamente

    except FileNotFoundError:
        raise Exception(f"No se encontró el archivo '{file_path}'.")  # Genera una excepción si no se encuentra el archivo de entrada



if __name__ == "__main__":
    file_path = "proyecto_2/Ensamblador/circle.asm"
    mem_path  = "proyecto_2/Procesador/instr-algo.txt"
    compile_code(file_path, mem_path)

    