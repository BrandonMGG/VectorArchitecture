// sine_calculator utiliza una instancia de sine_table para indexar los valores de la tabla en funcion 
// del angulo de entrada theta en radianes, luego utiliza la salida de la tabla para calcular el seno
// del angulo
module sine_calculator(
    input logic signed [31:0] theta,  // Entrada para el angulo en radianes (punto fijo Q31.0)
    output logic signed [31:0] sin    // Salida para el seno del angulo (punto fijo Q31.0)
  );
  
    // Parametros para la tabla de busqueda del seno
    parameter ROM_DEPTH = 64;  // numero de entradas en la tabla de busqueda para el rango de angulos de 0° a 90°
    parameter ROM_WIDTH = 8;   // ancho de datos de la tabla de busqueda
    parameter ROM_FILE = "C:/Users/HP/Desktop/TEC/I-2023/Arqui-I/Repo/jpena_computer_architecture_1_2023/proyecto_2/LUT/sine_lut.txt";   // ruta del archivo de inicializacion de la tabla de busqueda
    parameter ADDRW = $clog2(4*ROM_DEPTH);  // un circulo completo va de 0° a 360°
  
    logic signed [ADDRW-1:0] id;  // direccion de entrada para buscar en la tabla de busqueda
    logic signed [2*ROM_WIDTH-1:0] data;  // resultado (punto fijo) de la tabla de busqueda

    sine_table #(
      .ROM_DEPTH(ROM_DEPTH),
      .ROM_WIDTH(ROM_WIDTH),
      .ROM_FILE(ROM_FILE),
      .ADDRW(ADDRW)
    ) sine_lut (
      .id(id),
      .data(data)
    );
  
    // Convertir el angulo de entrada a una direccion en la tabla de busqueda
    always_comb begin
      id = ($signed({31'b0, theta}) * (1 << (ADDRW-1)) / 180) & ((1 << ADDRW) - 1);
    end
  
    // Utilizar la salida de la tabla de busqueda para calcular el seno del angulo
    always_comb begin
      if (theta < 0) begin
        sin = -data;
      end else begin
        sin = data;
      end
    end
  
  endmodule
  