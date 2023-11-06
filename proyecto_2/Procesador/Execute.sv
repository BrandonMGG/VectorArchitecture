/*
	Execution Module
	Inputs:
	- data1, data2
	- ALUControlE: alu operation mode
	
	Outputs:
	- ALUResultE: 
	- N, Z, V, C: alu flags
	
	Params: 
	- WIDTH: width of the data
*/
module Execute #(parameter WIDTH = 24)
	(input logic [WIDTH-1:0] data1, data2, data3, forwardM, forwardWB,
	 input logic [2:0] ALUControlE,
	 input logic ALUSrcE,
	 input logic [1:0] data1ForwardSelector, data2ForwardSelector,
	 output logic [WIDTH-1:0] data2AfterForward, ALUResultE,
	 output logic N, Z, V, C
	 );		
	
	logic [WIDTH-1:0] SrcAE;
	logic [WIDTH-1:0] SrcBE;
	
	/*
	Mux data1ExecStageMUX
		input: 
			data1 		-> Comes from RD1
			forwardWB	-> Comes from the writeBack stage
			forwardM		-> Comes from the beggining of the memory stage
			
		output:
			SrcAE			-> Value that will come to the ALU.
	*/

	mux3  #(WIDTH) data1ExecStageMUX(data1, forwardWB, forwardM, 
									data1ForwardSelector, SrcAE);
	mux3  #(WIDTH) data2ExecStageMUX(data2, forwardWB, forwardM, 
									data2ForwardSelector, data2AfterForward);	

	mux2  #(WIDTH) data2ExecStageMUXRegImm(data2AfterForward, data3, 
									ALUSrcE, SrcBE);

	
	ALU #(WIDTH) ALU( 
		 SrcAE, 
		 SrcBE,
		 ALUControlE,
		 ALUResultE,
		 N,
		 Z,
		 V,
		 C 
	);

endmodule

