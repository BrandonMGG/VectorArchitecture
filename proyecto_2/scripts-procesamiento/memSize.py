asciiList = []


for i in range(90000):
    asciiList.append('{:08b}'.format(0)+"\n" )

f = open("proyecto_2/Procesador/mem4.txt", "w")
f.writelines(asciiList)