module sine_table #(
    parameter ROM_DEPTH=64,  // numero de entradas en la tabla de busqueda para el rango de angulos de 0° a 90°
    parameter ROM_WIDTH=8,   // ancho de datos de la tabla de busqueda
    parameter ROM_FILE="C:/Users/HP/Desktop/TEC/I-2023/Arqui-I/Repo/jpena_computer_architecture_1_2023/proyecto_2/LUT/sine_lut.txt",   // ruta del archivo de inicializacion de la tabla de busqueda
    parameter ADDRW=$clog2(4*ROM_DEPTH)  // un círculo completo va de 0° a 360°
    ) (
    input  wire logic [ADDRW-1:0] id,  // direccion de entrada para buscar en la tabla de busqueda
    output      logic signed [2*ROM_WIDTH-1:0] data  // resultado (punto fijo)
    );

    // memoria ROM de la tabla de busqueda del seno: 0°-90°
    logic [$clog2(ROM_DEPTH)-1:0] tab_id;
    logic [ROM_WIDTH-1:0] tab_data;
    rom_async #(
        .WIDTH(ROM_WIDTH),
        .DEPTH(ROM_DEPTH),
        .INIT_F(ROM_FILE)
    ) sine_rom (
        .addr(tab_id),
        .data(tab_data)
    );

    logic [1:0] quad; //8-3 = 5
    always_comb begin
        quad = id[ADDRW-1:ADDRW-2]; // 0 63 -> 00_00_0000   00_11_11_11 64 01_00_00_00 I: 223 --> 00_1101_1111; II: 224---> 00_1110_0000 447-->01_1011_1111; III:448 ---> 01_1100_0000 671---->10_1001_1111 897 --->11_1000_0001
        case (quad)
            2'b00: tab_id = id[ADDRW-3:0];                // Cuadrante I:    0° a  90° | 0 a 63
            2'b01: tab_id = 2*ROM_DEPTH - id[ADDRW-3:0];  // Cuadrante II:  90° a 180° | 64 a 127
            2'b10: tab_id = id[ADDRW-3:0] - 2*ROM_DEPTH;  // Cuadrante III: 180° a 270° | 128 a 191
            2'b11: tab_id = 4*ROM_DEPTH - id[ADDRW-3:0];  // Cuadrante IV:  270° a 360° | 192 a 255
        endcase
    end

    always_comb begin
        if (id == ROM_DEPTH) begin  // sin(90°) = +1.0
            data = {{ROM_WIDTH-1{1'b0}}, 1'b1, {ROM_WIDTH{1'b0}}};
        end else if (id == 3*ROM_DEPTH) begin  // sin(270°) = -1.0
            data = {{ROM_WIDTH{1'b1}}, {ROM_WIDTH{1'b0}}};
        end else begin
            if (quad[1] == 0) begin  // positivo en los cuadrantes I y II
                data = {{ROM_WIDTH{1'b0}}, tab_data};
            end else begin
                data = {2*ROM_WIDTH{1'b0}} - {{ROM_WIDTH{1'b0}}, tab_data};
            end
        end
    end
endmodule
