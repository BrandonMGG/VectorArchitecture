from PIL import Image
import numpy as np
import imageio
import math

def fileReader(path):
    file = open(path, 'r')
    data = file.read()
    file.close()
    return data

def toList(data, separador):
    listedData = []
    temp = ''
    for i in data:
        if i != separador:
            temp += i
        else:
            listedData.append(int(temp))
            temp = ''
    listedData.append(int(temp))
    return listedData

def binaryToDecimal(binary):
    
    decimal, i = 0, 0
    while (binary != 0):
        dec = binary % 10
        decimal = decimal + dec * pow(2, i)
        binary = binary//10
        i += 1
    return decimal

def resizeImage(path):
    """
    resizeImage(path): redimensiona una imagen .jpg para que sea de tamaño 300x300 
    para propósitos de procesamiento de la asip.
    ----------
    Parámetros: 
        path: ruta de la imagen
    
    return: void
    """
    img = Image.open(path)
    img = img.resize((width,hsize), Image.LANCZOS)
    img.save(path)

def rgbToGray(path):
    """
    rgbToGray(path): convierte una imagen rgb a escala de grises 
    para aplicarle la transformación lineal.
    ----------
    Parámetros: 
        path: ruta de la imagen
    
    return: void
    """
    resizeImage(path=path)
    rgb_matrix = np.array(imageio.imread(path), dtype='int').tolist()
    print("RGB: ", len(rgb_matrix))
    grayscale = []
    for y in range(hsize):
        for x in range(width):
            data = rgb_matrix[y][x]
            data_av = (data[0]+data[1]+data[2])//3
            grayscale.append(data_av)
    return grayscale

# Aplicar la transformación lineal a cada valor de la lista
def linear_transformation(width:int, hsize:int, Lx:int, Ly:int, gray_list:list, out_path)-> list:
    """
    linear_transformation: aplica una transformación lineal a la lista de píxeles en gray_list
    en un rango de 2 a 16 con pasos de 2 en 2 (sujeto a cambios). 
    ----------
    Parametros: 
        width       : int, ancho de la imagen
        hsize       : int, alto de la imagen
        Lx          : int, periodo de transformación a coordenada X
        Ly          : int, periodo de transformación a coordenada Y
        gray_list   : list, lista con pixeles de imagen
    return: transformed_list, lista con valores nuevos
    """
    for k in range(5, 10, 5):
        transformed_list = []
        Ax = k
        Ay = k
        for i in range(len(gray_list)):
            x = i % width
            y = i // width
            xnew = math.floor((x + Ax * math.sin(2 * math.pi * y / Lx)))% width
            ynew = math.floor((y + Ay * math.sin(2 * math.pi * x / Ly)))% hsize
            index = ynew * width + xnew
            if i < 10:
                print(gray_list[index])
            transformed_list.append(gray_list[index])

        pic = Image.new('L', (width, hsize))
        pic.putdata(transformed_list)

    # Guardar la imagen
        pic.save(f"{out_path}gray_barbara_transformed{k}.jpg")
        pic.close()

def reSizer(binNum, bit_len):
    while len(binNum) < bit_len:
        binNum = '0' + binNum
    return binNum

def write_in_data(pic, _path):
    """
    write_in_data escribe los pixeles de entrada a la memoria
    """
    bit_len = 8
    path = _path
    i = 0
    file = open(path, "w")
    while i < len(pic):
        a = reSizer("{0:b}".format(pic[i]), bit_len)
        file.write(str(a)+"\n")
        i += 1
    file.close()

def bindigits(n, bits):
    s = bin(n & int("1"*bits, 2))[2:]
    return ("{0:0>%s}" % (bits)).format(s)

def cal_sin(Lx, mem_depth, mem_width, scale) -> list:
    result = []
    extra_data = 2 # para ubicar los valores 90000 y 180 000 en las posiciones 300 y 301
    for i in range(mem_depth):
        current_val = int(math.sin((2*math.pi*i)/Lx)*scale)
        to_mem = reSizer("{0:b}".format(current_val), mem_width)
        if current_val < 0:
            to_mem = bindigits(current_val, mem_width)
        result.append(to_mem)

    result.append(reSizer("{0:b}".format(90000), mem_width))
    result.append(reSizer("{0:b}".format(180000), mem_width))

    return result
 

def write_sine_mem(path, lx, mem_depth, mem_width, scale):
    to_write = cal_sin(lx, mem_depth, mem_width, scale)
    file = open(path, "w")
    i = 0
    while i < len(to_write):
        file.write(str(to_write[i])+"\n")
        i += 1

    file.close()

def bin_list_to_dec(list):
    result = []
    for i in range(len(list)):
        val = int(list[i])
        data = binaryToDecimal(val)
        if data > 255:
            data = 0
        result.append(data)
    return result

def create_out_image(path, width, hsize, out_path):
    transformed_image   = fileReader(path)
    image_list_bin  = toList(transformed_image, '\n')
    image_list      = bin_list_to_dec(image_list_bin)

    pic_enc         = Image.new('L', (width, hsize))
    pic_enc.putdata(image_list)
    pic_enc.save(out_path)
    pic_enc.close()
# data = cal_sin(80, 300, 24, 100)[0]
# print(isinstance(data, str))

if __name__ == "__main__":

    image_path = "barbara.jpg"
    #data_mem_path = "../Procesador/mem3.txt"
    #sine_mem_path = "../Procesador/mem2.txt"
    #out_path_image = "./out/outfile.png"
    #processed_image_path = "../Procesador/outfile.txt"
    width, hsize = 300, 300
    Lx = 80
    Ly = 80
    sine_mem_width = 24
    #create_out_image(data_mem_path, width, hsize, out_path_image)
    gray_list = rgbToGray(image_path)
    out_path = "out/"
    #write_sine_mem(sine_mem_path ,Lx, hsize, sine_mem_width, 100)
    #write_in_data(gray_list, data_mem_path)
    
    linear_transformation(width, hsize, Lx, Ly, gray_list, out_path)