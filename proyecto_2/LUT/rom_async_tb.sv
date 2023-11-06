module rom_async_tb();

  // Parametros del modulo de ROM
  localparam WIDTH = 8;        // Ancho de palabra de datos
  localparam DEPTH = 64;       // Profundidad de la memoria
  localparam INIT_F = "sine_lut.txt";   // Archivo de inicializacion

  // Senales de entrada y salida del testbench
  logic [WIDTH-1:0] data_out;    // Datos leidos desde la ROM
  logic [$clog2(DEPTH)-1:0] addr;   // Direccion de memoria a leer
  logic tb_clk;    // Senal de reloj del testbench

  // Instanciacion del DUT
  rom_async #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH),
    .INIT_F(INIT_F)
  ) dut (
    .addr(addr),
    .data(data_out)
  );

  // Generacion de la senal de reloj del testbench
  initial begin
    repeat(10) @(posedge tb_clk);   // Espera 10 ciclos de reloj
  end
  always #5 tb_clk = ~tb_clk;   // Genera un pulso de reloj cada 5 unidades de tiempo

  // Prueba de lectura en todas las direcciones de la ROM
  initial begin
    tb_clk <= 1;    // Inicializa la senal de reloj en 1
    $display("Starting read operation on ROM...");   // Imprime un mensaje en la consola
    for(int i = 0; i < DEPTH; i++) begin    // Recorre todas las direcciones de la ROM
      addr = i;   // Selecciona la direccion de memoria a leer
      @(posedge tb_clk);   // Espera al flanco de subida del reloj
      $display("Read from address %d: %h", addr, data_out);   // Imprime los datos leidos en la consola
    end
    $display("Finished read operation on ROM.");   // Imprime un mensaje en la consola
    $finish;    // Finaliza la simulacion
  end

  // Declaracion de la senal de reloj del testbench
  
  
endmodule
