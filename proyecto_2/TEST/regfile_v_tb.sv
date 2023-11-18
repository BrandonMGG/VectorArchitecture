module regfile_simple_tb;

  // Parámetros del módulo
  parameter WIDTH = 24;
  parameter REGNUM = 16;
  parameter VECTOR_WIDTH = 8;

  // Señales de la prueba
  logic clk;
  logic we;
  logic [3:0] reg_num;
  logic [2:0] index;
  logic [WIDTH-1:0] data_in;
  logic [3:0] reg_out;
  logic [VECTOR_WIDTH-1:0][WIDTH-1:0] data_out;

  // Instancia del módulo
  regfile_simple #(WIDTH, REGNUM, VECTOR_WIDTH)
    uut (.clk(clk), .we(we), .reg_num(reg_num), .index(index),
         .data_in(data_in), .reg_out(reg_out), .data_out(data_out));

  // Generador de estímulo
  initial begin
    clk = 0;
    we = 1;
    reg_num = 3;
    index = 2;
    data_in = 16'hABCDE;

    #5; // Esperar 5 unidades de tiempo

    // Probar lectura del registro y vector
    we = 0;
    #5; // Esperar 5 unidades de tiempo

    // Imprimir resultados
    $display("Registro %0d, Índice %0d: Valor %h", reg_out, index, data_out);

    // Terminar la simulación
    $finish;
  end

  // Generador de reloj
  always #1 clk = ~clk;

endmodule
