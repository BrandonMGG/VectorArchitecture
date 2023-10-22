#include <iostream>
#include <fstream>
#include <cmath>
#include <immintrin.h>

void print_m128i(__m128i myRegister,const char* label) {
    int myArray[4];
    _mm_storeu_si128((__m128i*)myArray, myRegister);

    std::cout << label << "  Elementos "  << " :(" << myArray[0]<< " : " << myArray[1]  << " : " << myArray[2]  << " : " << myArray[3]<<  ")"<< std::endl;
}

int main()
{
    const int width = 640;
    const int height = 480;

    // Crear una matriz para almacenar los píxeles (RGB)
    unsigned char pixels[height][width][3];

    // Inicializa la matriz de píxeles en blanco
    for (int y = 0; y < height; y++)
    {
        for (int x = 0; x < width; x += 4)
        {
            pixels[y][x][0] = 255;     // Red
            pixels[y][x][1] = 255;     // Green
            pixels[y][x][2] = 255;     // Blue
            pixels[y][x + 1][0] = 255; // Red
            pixels[y][x + 1][1] = 255; // Green
            pixels[y][x + 1][2] = 255; // Blue
            pixels[y][x + 2][0] = 255; // Red
            pixels[y][x + 2][1] = 255; // Green
            pixels[y][x + 2][2] = 255; // Blue
            pixels[y][x + 3][0] = 255; // Red
            pixels[y][x + 3][1] = 255; // Green
            pixels[y][x + 3][2] = 255; // Blue
        }
    }

    // Dibujar un círculo (sin fondo)
    int circleX = 320;
    int circleY = 240;
    int circleRadius = 205;
    unsigned char circleColor[3] = {41, 176, 92}; // Color negro

    
    const double circleRadiusSquared = circleRadius * circleRadius;

    for (int y = 0; y < height ; y++)
    {
    //int y = 38;
        for (int x = 0; x < width; x += 4)
        {
            // Cargar 4 valores  x, y un y en los registros
            __m128i xValues = _mm_set_epi32(x, x + 1, x + 2, x + 3);
            //print_m128i(xValues,"xValues");
            __m128i yValues = _mm_set1_epi32(y - circleY);
            //print_m128i(yValues,"yValues");
            // Calcular (x - circleX)^2 
            __m128i dx = _mm_sub_epi32(xValues, _mm_set1_epi32(circleX));
            //print_m128i(dx,"dx");
            __m128i dxSquared = _mm_mullo_epi32(dx, dx);
            //print_m128i(dxSquared,"dxSquared");
            // Calcular (x - circleX)^2 + (y - circleY)^2 
            __m128i dySquared = _mm_mullo_epi32(yValues, yValues);
            //print_m128i(dySquared,"dySquared");
            __m128i distanceSquared = _mm_add_epi32(dxSquared, dySquared);
            //print_m128i(distanceSquared,"distanceSquared");
            // Comparacion distance < radius

            /*
            genera una máscara de enteros de 128 bits en comparación donde cada elemento se establece 
            en 0xFFFFFFFF (todos 1) si el elemento correspondiente en distanceSquared es menor que 
            el elemento correspondiente en radiusSquared, y 0 en caso contrario.
            */
            __m128i radiusSquared = _mm_set1_epi32(static_cast<int>(circleRadiusSquared));
            //print_m128i(radiusSquared,"radiusSquared");
            __m128i comparison = _mm_cmplt_epi32(distanceSquared, radiusSquared);
            //print_m128i(comparison,"comparison");
            /*
            mask es un entero de 4 bits donde cada bit corresponde a uno de los cuatro
             píxeles que se comparan.

             _mm_movemask_ps pasa la mascara de forma vectorial a escalar
            */

            __m128i mask = _mm_set1_epi32(0xFFFFFFFF);  // Máscara para comparación
            __m128i equalResult = _mm_cmpeq_epi32(comparison, mask);  // Comparación de elementos
            //print_m128i(equalResult,"equalResult");
            // Utilizar una matriz de int32_t para almacenar los resultados
            int32_t results[4];
            _mm_storeu_si128((__m128i*)results, equalResult);  // Almacena los resultados en la matriz

            for (int i = 0; i < 4; i++) {
                if (results[i] == 0xFFFFFFFF) {
                    // Si el elemento es igual a 0xFFFFFFFF, entra al if
                    // Realiza las acciones correspondientes
                    pixels[y][x + (3 - i)][0] = circleColor[0]; // Rojo
                    pixels[y][x + (3 - i)][1] = circleColor[1]; // Verde
                    pixels[y][x + (3 - i)][2] = circleColor[2]; // Azul
                }
            }
        }
    }

    // Dibujar un cuadrado (sin fondo)
    int squareX = 176;
    int squareY = 96;
    int squareSize = 290;
    unsigned char squareColor[3] = {77, 198, 123}; // Color negro

    for (int y = squareY; y < squareY + squareSize; y++) {
        for (int x = 0; x < width; x += 4) {
            // Cargar 4 valores x, y un y en los registros
            __m128i xValues = _mm_set_epi32(x, x + 1, x + 2, x + 3);
            __m128i yValues = _mm_set1_epi32(y - squareY);

            // Verificar si estamos dentro de los límites del cuadrado
            __m128i withinSquareBounds = _mm_and_si128(
                _mm_cmpgt_epi32(xValues, _mm_set1_epi32(squareX)),
                _mm_cmplt_epi32(xValues, _mm_set1_epi32(squareX + squareSize))
            );

            withinSquareBounds = _mm_and_si128(
                withinSquareBounds,
                _mm_cmpgt_epi32(yValues, _mm_set1_epi32(0))
            );

            withinSquareBounds = _mm_and_si128(
                withinSquareBounds,
                _mm_cmplt_epi32(yValues, _mm_set1_epi32(squareSize))
            );

            // Utilizar una matriz de int32_t para almacenar los resultados
            int32_t results[4];
            _mm_storeu_si128((__m128i*)results, withinSquareBounds);  // Almacena los resultados en la matriz

            for (int i = 0; i < 4; i++) {
                if (results[i] == 0xFFFFFFFF) {
                    // Si el elemento es igual a 0xFFFFFFFF, entra al if
                    // Realiza las acciones correspondientes
                    pixels[y][x + (3 - i)][0] = squareColor[0]; // Rojo
                    pixels[y][x + (3 - i)][1] = squareColor[1]; // Verde
                    pixels[y][x + (3 - i)][2] = squareColor[2]; // Azul
                }
            }
        }
    }

    // Definir las coordenadas de un triángulo (sin fondo)
    int triangleX[3] = {320, 465, 176};
    int triangleY[3] = {36, 95, 95};
    unsigned char triangleColor[3] = {10, 98, 134}; // Color negro

    for (int i = 0; i < 3; i++) {
        int x1 = triangleX[i];
        int y1 = triangleY[i];
        int x2 = triangleX[(i + 1) % 3];
        int y2 = triangleY[(i + 1) % 3];

        // Algoritmo de trazado de línea (Bresenham) para dibujar el triángulo
        int dx = std::abs(x2 - x1);
        int dy = std::abs(y2 - y1);
        int sx = (x1 < x2) ? 1 : -1;
        int sy = (y1 < y2) ? 1 : -1;
        int err = dx - dy;

        __m128i xValues = _mm_set1_epi32(x1);
        __m128i yValues = _mm_set1_epi32(y1);


        while (x1 != x2 || y1 != y2) {
            // Utilizar instrucciones SIMD para mejorar el rendimiento
            __m128i xyValues = _mm_unpacklo_epi32(xValues, yValues);

            int x = _mm_cvtsi128_si32(xValues);
            int y = _mm_cvtsi128_si32(yValues);

            if (x >= 0 && x < width && y >= 0 && y < height) {
                // Establecer el color del píxel
                pixels[y][x][0] = triangleColor[0]; // Rojo
                pixels[y][x][1] = triangleColor[1]; // Verde
                pixels[y][x][2] = triangleColor[2]; // Azul
            }

            int e2 = 2 * err;
            if (e2 > -dy) {
                err = err - dy;
                xValues = _mm_add_epi32(xValues, _mm_set1_epi32(sx));
                x1 += sx; // Actualizar x1
            }
            if (e2 < dx) {
                err = err + dx;
                yValues = _mm_add_epi32(yValues, _mm_set1_epi32(sy));
                y1 += sy; // Actualizar y1
            }
        }
    }

    // Definir las coordenadas de un triángulo (sin fondo)
    int triangleX2[3] = {320, 465, 176};
    int triangleY2[3] = {444, 386, 386};

    for (int i = 0; i < 3; i++)
    {
        int x1 = triangleX2[i];
        int y1 = triangleY2[i];
        int x2 = triangleX2[(i + 1) % 3];
        int y2 = triangleY2[(i + 1) % 3];

        // Algoritmo de trazado de línea (Bresenham) para dibujar el triángulo
        int dx = std::abs(x2 - x1);
        int dy = std::abs(y2 - y1);
        int sx = (x1 < x2) ? 1 : -1;
        int sy = (y1 < y2) ? 1 : -1;
        int err = dx - dy;

        while (x1 != x2 || y1 != y2)
        {
            if (x1 >= 0 && x1 < width && y1 >= 0 && y1 < height)
            {
                pixels[y1][x1][0] = triangleColor[0]; // Rojo
                pixels[y1][x1][1] = triangleColor[1]; // Verde
                pixels[y1][x1][2] = triangleColor[2]; // Azul
            }

            int e2 = 2 * err;
            if (e2 > -dy)
            {
                err = err - dy;
                x1 = x1 + sx;
            }
            if (e2 < dx)
            {
                err = err + dx;
                y1 = y1 + sy;
            }
        }
    }

    // Definir las coordenadas de un triángulo (sin fondo)
    int triangleX3[3] = {115, 176, 176};
    int triangleY3[3] = {240, 95, 386};

    for (int i = 0; i < 3; i++)
    {
        int x1 = triangleX3[i];
        int y1 = triangleY3[i];
        int x2 = triangleX3[(i + 1) % 3];
        int y2 = triangleY3[(i + 1) % 3];

        // Algoritmo de trazado de línea (Bresenham) para dibujar el triángulo
        int dx = std::abs(x2 - x1);
        int dy = std::abs(y2 - y1);
        int sx = (x1 < x2) ? 1 : -1;
        int sy = (y1 < y2) ? 1 : -1;
        int err = dx - dy;

        while (x1 != x2 || y1 != y2)
        {
            if (x1 >= 0 && x1 < width && y1 >= 0 && y1 < height)
            {
                pixels[y1][x1][0] = triangleColor[0]; // Rojo
                pixels[y1][x1][1] = triangleColor[1]; // Verde
                pixels[y1][x1][2] = triangleColor[2]; // Azul
            }

            int e2 = 2 * err;
            if (e2 > -dy)
            {
                err = err - dy;
                x1 = x1 + sx;
            }
            if (e2 < dx)
            {
                err = err + dx;
                y1 = y1 + sy;
            }
        }
    }

    // Definir las coordenadas de un triángulo (sin fondo)
    int triangleX4[3] = {525, 465, 465};
    int triangleY4[3] = {240, 95, 386};

    for (int i = 0; i < 3; i++)
    {
        int x1 = triangleX4[i];
        int y1 = triangleY4[i];
        int x2 = triangleX4[(i + 1) % 3];
        int y2 = triangleY4[(i + 1) % 3];

        // Algoritmo de trazado de línea (Bresenham) para dibujar el triángulo
        int dx = std::abs(x2 - x1);
        int dy = std::abs(y2 - y1);
        int sx = (x1 < x2) ? 1 : -1;
        int sy = (y1 < y2) ? 1 : -1;
        int err = dx - dy;

        while (x1 != x2 || y1 != y2)
        {
            if (x1 >= 0 && x1 < width && y1 >= 0 && y1 < height)
            {
                pixels[y1][x1][0] = triangleColor[0]; // Rojo
                pixels[y1][x1][1] = triangleColor[1]; // Verde
                pixels[y1][x1][2] = triangleColor[2]; // Azul
            }

            int e2 = 2 * err;
            if (e2 > -dy)
            {
                err = err - dy;
                x1 = x1 + sx;
            }
            if (e2 < dx)
            {
                err = err + dx;
                y1 = y1 + sy;
            }
        }
    }

    // Dibujar un cuadrado (sin fondo)
    int squareX2 = 191;
    int squareY2 = 111;
    int squareSize2 = 260;
    unsigned char squareColor2[3] = {119, 176, 140}; // Color negro

    for (int y = squareY2; y < squareY2 + squareSize2; y++)
    {
        for (int x = squareX2; x < squareX2 + squareSize2; x++)
        {
            if (x >= 0 && x < width && y >= 0 && y < height)
            {
                pixels[y][x][0] = squareColor2[0]; // Rojo
                pixels[y][x][1] = squareColor2[1]; // Verde
                pixels[y][x][2] = squareColor2[2]; // Azul
            }
        }
    }

    // Dibujar un círculo (sin fondo)
    int circleX2 = 320;
    int circleY2 = 240;
    int circleRadius2 = 130;
    unsigned char circleColor2[3] = {162, 246, 194}; // Color negro

    for (int y = 0; y < height; y++)
    {
        for (int x = 0; x < width; x++)
        {
            double distance2 = std::sqrt((x - circleX2) * (x - circleX2) + (y - circleY2) * (y - circleY2));
            if (distance2 < circleRadius2)
            {
                pixels[y][x][0] = circleColor2[0]; // Rojo
                pixels[y][x][1] = circleColor2[1]; // Verde
                pixels[y][x][2] = circleColor2[2]; // Azul
            }
        }
    }

    // Definir las coordenadas de un triángulo (sin fondo)
    int triangleX5[3] = {320, 243, 320};
    int triangleY5[3] = {110, 345, 290};

    for (int i = 0; i < 3; i++)
    {
        int x1 = triangleX5[i];
        int y1 = triangleY5[i];
        int x2 = triangleX5[(i + 1) % 3];
        int y2 = triangleY5[(i + 1) % 3];

        // Algoritmo de trazado de línea (Bresenham) para dibujar el triángulo
        int dx = std::abs(x2 - x1);
        int dy = std::abs(y2 - y1);
        int sx = (x1 < x2) ? 1 : -1;
        int sy = (y1 < y2) ? 1 : -1;
        int err = dx - dy;

        while (x1 != x2 || y1 != y2)
        {
            if (x1 >= 0 && x1 < width && y1 >= 0 && y1 < height)
            {
                pixels[y1][x1][0] = triangleColor[0]; // Rojo
                pixels[y1][x1][1] = triangleColor[1]; // Verde
                pixels[y1][x1][2] = triangleColor[2]; // Azul
            }

            int e2 = 2 * err;
            if (e2 > -dy)
            {
                err = err - dy;
                x1 = x1 + sx;
            }
            if (e2 < dx)
            {
                err = err + dx;
                y1 = y1 + sy;
            }
        }
    }

    // Definir las coordenadas de un triángulo (sin fondo)
    int triangleX6[3] = {320, 320, 400};
    int triangleY6[3] = {110, 290, 345};

    for (int i = 0; i < 3; i++)
    {
        int x1 = triangleX6[i];
        int y1 = triangleY6[i];
        int x2 = triangleX6[(i + 1) % 3];
        int y2 = triangleY6[(i + 1) % 3];

        // Algoritmo de trazado de línea (Bresenham) para dibujar el triángulo
        int dx = std::abs(x2 - x1);
        int dy = std::abs(y2 - y1);
        int sx = (x1 < x2) ? 1 : -1;
        int sy = (y1 < y2) ? 1 : -1;
        int err = dx - dy;

        while (x1 != x2 || y1 != y2)
        {
            if (x1 >= 0 && x1 < width && y1 >= 0 && y1 < height)
            {
                pixels[y1][x1][0] = triangleColor[0]; // Rojo
                pixels[y1][x1][1] = triangleColor[1]; // Verde
                pixels[y1][x1][2] = triangleColor[2]; // Azul
            }

            int e2 = 2 * err;
            if (e2 > -dy)
            {
                err = err - dy;
                x1 = x1 + sx;
            }
            if (e2 < dx)
            {
                err = err + dx;
                y1 = y1 + sy;
            }
        }
    }

    // Definir las coordenadas de un triángulo (sin fondo)
    int triangleX7[3] = {197, 320, 445};
    int triangleY7[3] = {200, 290, 200};

    for (int i = 0; i < 3; i++)
    {
        int x1 = triangleX7[i];
        int y1 = triangleY7[i];
        int x2 = triangleX7[(i + 1) % 3];
        int y2 = triangleY7[(i + 1) % 3];

        // Algoritmo de trazado de línea (Bresenham) para dibujar el triángulo
        int dx = std::abs(x2 - x1);
        int dy = std::abs(y2 - y1);
        int sx = (x1 < x2) ? 1 : -1;
        int sy = (y1 < y2) ? 1 : -1;
        int err = dx - dy;

        while (x1 != x2 || y1 != y2)
        {
            if (x1 >= 0 && x1 < width && y1 >= 0 && y1 < height)
            {
                pixels[y1][x1][0] = triangleColor[0]; // Rojo
                pixels[y1][x1][1] = triangleColor[1]; // Verde
                pixels[y1][x1][2] = triangleColor[2]; // Azul
            }

            int e2 = 2 * err;
            if (e2 > -dy)
            {
                err = err - dy;
                x1 = x1 + sx;
            }
            if (e2 < dx)
            {
                err = err + dx;
                y1 = y1 + sy;
            }
        }
    }

    // Dibujar un círculo (sin fondo)
    int circleX3 = 320;
    int circleY3 = 240;
    int circleRadius3 = 50;
    unsigned char circleColor3[3] = {243, 79, 124}; // Color negro

    for (int y = 0; y < height; y++)
    {
        for (int x = 0; x < width; x++)
        {
            double distance3 = std::sqrt((x - circleX3) * (x - circleX3) + (y - circleY3) * (y - circleY3));
            if (distance3 < circleRadius3)
            {
                pixels[y][x][0] = circleColor3[0]; // Rojo
                pixels[y][x][1] = circleColor3[1]; // Verde
                pixels[y][x][2] = circleColor3[2]; // Azul
            }
        }
    }

    // Dibujar un círculo (sin fondo)
    int circleX4 = 320;
    int circleY4 = 240;
    int circleRadius4 = 40;
    unsigned char circleColor4[3] = {70, 238, 70}; // Color negro

    for (int y = 0; y < height; y++)
    {
        for (int x = 0; x < width; x++)
        {
            double distance4 = std::sqrt((x - circleX4) * (x - circleX4) + (y - circleY4) * (y - circleY4));
            if (distance4 < circleRadius4)
            {
                pixels[y][x][0] = circleColor4[0]; // Rojo
                pixels[y][x][1] = circleColor4[1]; // Verde
                pixels[y][x][2] = circleColor4[2]; // Azul
            }
        }
    }

    // Guardar los píxeles en un archivo de texto
    std::ofstream outputFile("pixels.txt");
    for (int y = 0; y < height; y++)
    {
        for (int x = 0; x < width; x++)
        {
            outputFile << static_cast<int>(pixels[y][x][0]) << " "
                       << static_cast<int>(pixels[y][x][1]) << " "
                       << static_cast<int>(pixels[y][x][2]) << "\n";
        }
    }
    outputFile.close();

    return 0;
}
