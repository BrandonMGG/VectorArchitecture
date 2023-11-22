`timescale 1 ns / 1 ns
module outdebug();


	parameter WIDTH = 24;
	parameter REGNUM = 16; 
	parameter ADDRESSWIDTH = 4; 
	parameter OPCODEWIDTH = 4;
	parameter INSTRUCTIONWIDTH = 24;
	
	
	logic clock, reset; 
	logic outFlag;
	logic [WIDTH-1:0] out;
	

	logic startIO;
	
	CPU #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) CPU
	(clock, reset, startIO,
	outFlag,
	out );


	always begin
	
		#10 clock = ~clock; // medio ciclo de reloj equivale a una unidad
		
	end
	initial begin
		startIO = 0;
		//OutFile = $fopen("C://Users//HP//Desktop//TEC//I-2023//Arqui-I//Repo//jpena_computer_architecture_1_2023//proyecto_2//Procesador//outfile.txt");

		reset = 1;
		clock = 0;
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
	
		#10;
		
		#12620600;
		startIO = 1;
		#100000;
		$stop;

		
	end
	
endmodule 