// Project F Library - Sine Table Test Bench
// (C)2021 Will Green, open source hardware released under the MIT License
// Learn more at https://projectf.io

`default_nettype none
`timescale 1ns / 1ps

// Se define el testbench para el modulo de tabla de seno
module sine_table_tb ();
    // Se definen los parametros del modulo de tabla de seno
    localparam SF = 2.0**-8.0;  // Factor de escala Q8.8 es 2^-8
    localparam ROM_DEPTH=224;    // Numero de entradas en la ROM de seno para 0° a 90°
    localparam ROM_WIDTH=8;     // Ancho de datos de la ROM de seno
    localparam ROM_FILE="C:/Users/HP/Desktop/TEC/I-2023/Arqui-I/Repo/jpena_computer_architecture_1_2023/proyecto_2/LUT/sine_lut.txt";  // Archivo para poblar la ROM
    localparam ADDRW=$clog2(4*ROM_DEPTH);  // Un circulo completo es de 0° a 360°

    // Se definen las senales de entrada y salida del modulo
    logic [ADDRW-1:0] id;  // Identificador de tabla a buscar
    logic signed [2*ROM_WIDTH-1:0] data; // Respuesta
    sine_table #(
        .ROM_DEPTH(ROM_DEPTH),
        .ROM_WIDTH(ROM_WIDTH),
        .ROM_FILE(ROM_FILE)
    ) sine_table_inst (
        .id,
        .data
    );

    initial begin
        #100 id =   0;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id =   1;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id =  21;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id =  32;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id =  43;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id =  63;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id =  64;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id =  65;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id = 100;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id = 127;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id = 128;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id = 129;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id = 149;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id = 191;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id = 192;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id = 193;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id = 224;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #10 id = 255;
        #10 $display("%d = %b (%f)", id, data, $itor(data)*SF);

        #50 $finish();
    end
endmodule