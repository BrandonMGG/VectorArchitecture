`timescale 1 ns / 1 ns
module test_mem();


	parameter WIDTH = 24;
	parameter PIXEL = 8;
	parameter INSTRUCTIONWIDTH = 24;
	logic clk, we;
	logic [WIDTH-1:0] a1, a2, wd;
	logic [INSTRUCTIONWIDTH-1:0] rd1;
	logic [WIDTH-1:0] rd2;
	
	topMemory #(WIDTH, INSTRUCTIONWIDTH) mem
  (clk, we,
	a1, a2, wd,
	rd1,
	rd2);
		
	initial 
	begin
	
		we = 1;
	   a1 = 0;
		a2 = 17;
		wd = 8'h25;
		
	   clk = 0;		
		#10;
	   clk = 1;
		#10;
		we = 0;
		a1 = a1+1;
		a2 = 7;
	   clk = 0;
		#10;
	   clk = 1;
		#10;
		a1 = a1+1;
	   clk = 0;
		#10;
	   clk = 1;
		#10;
		a1 = a1+1;
	   clk = 0;
		we = 1;
		#10;
	   clk = 1;
		#10;
		we = 0;
		a2 = 17;
		a1 = a1+1;
	   clk = 0;
		#10;
	   clk = 1;
	end
	
endmodule 