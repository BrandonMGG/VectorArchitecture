module testExecute
				#(parameter WIDTH = 16, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
				parameter INSTRUCTIONWIDTH = 24)();

	logic clk;
	logic [2:0] aluControlEE;
	logic data2SelectorEE;
	logic [1:0] data1ForwardSelectorE, data2ForwardSelectorE;
	logic [WIDTH-1:0] reg1ContentE, reg2ContentE, inmmediateE, forwardM, forwardWB;
	logic [WIDTH-1:0] aluOutputE;
	logic N, Z, V, C;
	
	CPU_Execute testExecute(clk,
					aluControlEE,
					data2SelectorEE,
					data1ForwardSelectorE, data2ForwardSelectorE,
					reg1ContentE, reg2ContentE, inmmediateE, forwardM, forwardWB,
					aluOutputE,
					N, Z, V, C
					);				
								
	//Creacion de un reloj
	always begin
		clk = 0; #5; clk=~clk; #5;
	end
	
	initial begin	
		#5; 
		
		// Ejemplo 1: ADD R1, R4, R5 (suponer R4 = 4, R5 = 4) 
		reg1ContentE = 16'd4; reg2ContentE = 16'd4; inmmediateE = 16'd0;
		aluControlEE = 3'd0;
		data2SelectorEE = 0; data1ForwardSelectorE = 2'd0; data2ForwardSelectorE = 2'd0;
		#10;
		
		// Ejemplo 2 (RAW): SUB R8, R1, R3 (suponer R3 = 2, R1 -> dato del WB) 
		reg1ContentE = 16'd0; // valor basura 
		reg2ContentE = 16'd2; inmmediateE = 16'd0;
		forwardWB = 16'd8; // valor real -> desde WB
		aluControlEE = 3'd1;
		data2SelectorEE = 0; data1ForwardSelectorE = 2'd1; data2ForwardSelectorE = 2'd0;
		#10;
		
	end
								
								
endmodule
