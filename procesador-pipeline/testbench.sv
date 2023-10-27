`timescale 1 ps / 1 ps
module testbench();

	logic clk;
	logic rst;
	logic switchStart;
	
	procesador_pipeline procesador(clk, rst, switchStart);
	
	always begin
	
		#1 clk = ~clk; // medio ciclo de reloj equivale a una unidad
		
	end
	
	initial begin
		
		// señales iniciales
		rst = 1;
		clk = 1;
		switchStart = 0;
		
		#1
		
		rst = 0;
		
		#33000000;
		
		switchStart = 1;
		
	end
		
endmodule