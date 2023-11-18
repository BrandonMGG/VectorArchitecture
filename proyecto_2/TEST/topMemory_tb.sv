module topMemory_tb;

  // Señales de la prueba
  logic clk;
  logic we;
  logic startIO;
  logic [23:0] a2;
  logic [23:0] wd;
  logic [23:0] rd2;

  // Instancia del módulo
  topMemory #(24, 24, 24) uut (
    .clk(clk),
    .we(we),
    .startIO(startIO),
    .a2(a2),
    .wd(wd),
    .rd2(rd2)
  );

  // Generador de estímulo
  initial begin
    // Inicialización de señales
    clk = 0;
    we = 0;
    startIO = 0;
    a2 = 0;
    wd = 0;



    // Leer 4 valores de direcciones menores a 24
    for (int i = 0; i < 4; i = i + 1) begin
      a2 = i;
      we = 0;
      #10;
    end

    // Escribir los primeros 4 valores después de la dirección 25
    startIO = 0;
    a2 = 24;
    we = 1;
    wd = 24'h111111;
    #10;
	 a2 = 25;
    wd = 24'h222222;
    #10;
	 a2 = 26;
    wd = 24'h333333;
    #10;
	 a2 = 27;
    wd = 24'h444444;
    #10;
    startIO = 0;
    we = 0;

    // Leer los 4 valores escritos
    for (int i = 0; i < 4; i = i + 1) begin
      a2 = 25 + i;
      we = 0;
      #10;
    end

    // Terminar la simulación
    #10;
	 startIO = 1;
	 #10;
    $finish;
  end
  // Generador de reloj
  always #1 clk = ~clk;
  
endmodule
