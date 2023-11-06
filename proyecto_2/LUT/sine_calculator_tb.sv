module sine_calculator_tb();
    // Declaracion de senales para el testbench
    logic signed [31:0] address;
    logic signed [31:0] data_out;
    logic tb_clk;
  
    // Instanciacion del DUT
    sine_calculator dut (
      .address(address),
      .data_out(data_out)
    );
  
    // Generacion de una senal de reloj para el testbench
    initial begin
      repeat(10) @(posedge tb_clk);
    end
    always #5 tb_clk = ~tb_clk;
  
    // Realizacion de una operacion de lectura para cada valor de x
    initial begin
      tb_clk <= 1;
      $display("Comenzando el cálculo del seno...");
      for(real x = -5.0; x <= 5.0; x = x + 0.1) begin
        address = $signed(x * 300); // Conversion del ángulo en radianes a una direccion en la tabla de busqueda
        @(posedge tb_clk);
        $display("sin(%f) = %f (aprox. %h)", x, $itor(data_out)/$itor(1<<16), data_out); // Impresion del resultado de la operacion de lectura
      end
      $display("Finalizando el cálculo del seno.");
      $finish; // Terminacion del testbench
    end

  endmodule
  