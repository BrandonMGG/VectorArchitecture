module dInMem_tb;

  // Parámetros del módulo
  parameter WIDTH = 24;
  parameter AMOUNT = 90000;
  parameter PIXEL = 8;

  // Señales de la prueba
  logic [WIDTH-1:0] a;
  logic [WIDTH-1:0] rd;

  // Instancia del módulo
  dInMem #(WIDTH, AMOUNT, PIXEL) uut (.a(a), .rd(rd));

  // Generador de estímulo
  initial begin
    // Simular acceso a direcciones de memoria
    // Pon cuatro direcciones específicas
    a = 0; #10;
    $display("Direccion: %0d, Valor: %h", a, rd);

    a = 1; #10;
    $display("Direccion: %0d, Valor: %h", a, rd);

    a = 2; #10;
    $display("Direccion: %0d, Valor: %h", a, rd);

    a = 3; #10;
    $display("Direccion: %0d, Valor: %h", a, rd);

    // Terminar la simulación
    $finish;
  end

endmodule
