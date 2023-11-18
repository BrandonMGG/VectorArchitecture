module dOutMem_tb;

  // Parámetros del módulo
  parameter WIDTH = 24;
  parameter DEPTH = 10000;
  parameter PIXEL = 8;

  // Señales de la prueba
  logic startIO;
  logic clk;
  logic we;
  logic [WIDTH-1:0] address;
  logic [WIDTH-1:0] wd;

  // Instancia del módulo
  dOutMem #(WIDTH, DEPTH, PIXEL) uut (
    .startIO(startIO),
    .clk(clk),
    .we(we),
    .address(address),
    .wd(wd)
  );

  // Generador de estímulo
  initial begin
    // Inicialización de señales
    startIO = 0;
    clk = 0;
    we = 0;
    address = 0;
    wd = 0;



    // Escritura en direcciones diferentes
    // Escritura 1 en la dirección 0
    #10;
    startIO = 0;
    we = 1;
    address = 24'h000000;
    wd = 24'hABCDEF;
    #10;
    we = 0;

    // Escritura 2 en la dirección 100
    #10;
    startIO = 0;
    we = 1;
    address = 24'h000064;
    wd = 24'h112233;
    #10;
    we = 0;

    // Escritura 3 en la dirección 200
    #10;
    startIO = 0;
    we = 1;
    address = 24'h0000C8;
    wd = 24'h445566;
    #10;
    we = 0;

    // Escritura 4 en la dirección 300
    #10;
    startIO = 0;
    we = 1;
    address = 24'h00012C;
    wd = 24'h778899;
    #10;
    we = 0;

    // Terminar la simulación
    #10;
	 startIO = 1;
	 #10;
    $finish;
  end
  
  // Generador de reloj
  always #1 clk = ~clk;
  
endmodule
