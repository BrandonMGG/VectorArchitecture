#include <iostream>
#include <fstream>
#include <cstdlib>
#include <ctime>
#include <cmath>

int main() {
    const int width = 640;
    const int height = 480;
    const int numShapes = 100;

    // Inicializar la semilla para los números aleatorios
    std::srand(static_cast<unsigned>(std::time(nullptr)));

    // Crear una matriz para almacenar los píxeles (RGB)
    unsigned char pixels[height][width][3];

    // Crear una imagen degradada con valores RGB utilizando vectorización
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // Calcula los componentes RGB basados en la posición
            pixels[y][x][0] = static_cast<unsigned char>(x % 256);  // Rojo
            pixels[y][x][1] = static_cast<unsigned char>(y % 256);  // Verde
            pixels[y][x][2] = static_cast<unsigned char>((x + y) % 256);  // Azul
        }
    }

    // Dibujar círculos y cuadrados aleatorios
    for (int i = 0; i < numShapes; i++) {
        int shapeType = std::rand() % 2;  // 0 para círculo, 1 para cuadrado

        // Generar coordenadas y tamaño aleatorio dentro de los límites de la matriz
        int shapeX = std::rand() % (width - 50);
        int shapeY = std::rand() % (height - 50);
        int shapeSize = std::rand() % 50 + 10;

        // Generar un color aleatorio
        unsigned char shapeColor[3] = {
            static_cast<unsigned char>(std::rand() % 256),  // Rojo
            static_cast<unsigned char>(std::rand() % 256),  // Verde
            static_cast<unsigned char>(std::rand() % 256)   // Azul
        };

        if (shapeType == 0) {  // Dibujar círculo
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {
                    double distance = std::sqrt((x - shapeX) * (x - shapeX) + (y - shapeY) * (y - shapeY));
                    if (distance < shapeSize) {
                        pixels[y][x][0] = shapeColor[0];  // Rojo
                        pixels[y][x][1] = shapeColor[1];  // Verde
                        pixels[y][x][2] = shapeColor[2];  // Azul
                    }
                }
            }
        } else {  // Dibujar cuadrado
            for (int y = shapeY; y < shapeY + shapeSize; y++) {
                for (int x = shapeX; x < shapeX + shapeSize; x++) {
                    if (x >= 0 && x < width && y >= 0 && y < height) {
                        pixels[y][x][0] = shapeColor[0];  // Rojo
                        pixels[y][x][1] = shapeColor[1];  // Verde
                        pixels[y][x][2] = shapeColor[2];  // Azul
                    }
                }
            }
        }
    }

    // Guardar los píxeles en un archivo de texto
    std::ofstream outputFile("pixels.txt");
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            outputFile << static_cast<int>(pixels[y][x][0]) << " "
                       << static_cast<int>(pixels[y][x][1]) << " "
                       << static_cast<int>(pixels[y][x][2]) << "\n";
        }
    }
    outputFile.close();

    return 0;
}
