module rom_async #(
    parameter WIDTH=8,                           // Ancho de palabra de la memoria
    parameter DEPTH=256,                         // Profundidad de la memoria
    parameter INIT_F="sine_lut.txt"              // Ruta del archivo de inicializacion de la memoria
    ) (
    input wire logic [$clog2(DEPTH)-1:0] addr,   // Puerto de entrada para la direccion de memoria
    output     logic [WIDTH-1:0] data           // Puerto de salida para los datos de memoria
    );

    logic [WIDTH-1:0] memory [0:DEPTH-1];         // Matriz para almacenar los datos de la memoria

    initial $readmemh(INIT_F, memory);            // Leer los datos iniciales del archivo y cargarlos en la matriz de memoria

    always_comb data = memory[addr];              // Asignar el valor almacenado en la direccion especificada por "addr" al puerto de salida "data"

endmodule
