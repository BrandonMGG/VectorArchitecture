`timescale 1ns/1ns

module topMemory_vtb;

  // Parámetros del módulo
  parameter WIDTH = 24;
  parameter DEPTH = 10000;
  parameter PIXEL = 8;
  parameter VECTOR_WIDTH = 8;
  // Señales de la prueba
  logic startIO;
  logic clk;
  logic we;
  logic [WIDTH-1:0] address,rd2;
  logic [VECTOR_WIDTH-1:0][WIDTH-1:0] wd;

  // Instancia del módulo
  topMemory_v #(24, 10000, 8,8) uut (
    .clk(clk),
    .we(we),
    .startIO(startIO),
    .address(address),
    .wd(wd),
    .rd(rd2)
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
    address = 24'h000018;
	 wd = {24'h000001, 24'h000002, 24'h000003, 24'h000004, 24'h000005, 24'h000006, 24'h000007, 24'h000008};
	 #10;
	 we = 0;
	 address = 24'h000000;
    // Escritura 2 en la dirección 100
    #40;
    //startIO = 0;
    we = 1;
    address = 24'h000020;
    wd = {24'h000009, 24'h000010, 24'h000011, 24'h000012, 24'h000013, 24'h000014, 24'h000015, 24'h000016};
    #40;
    


    // Terminar la simulación
    #10;
	 we = 0;
	 startIO = 1;
	 #10;
    $stop;
  end
  
  // Generador de reloj
  always #1 clk = ~clk;
  
endmodule
