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
module Execute #(parameter WIDTH = 24,parameter VECTOR_WIDTH = 8)
	(input logic [WIDTH-1:0] data1, data2, data3, forwardM, forwardWB,
	 input logic [2:0] ALUControlE,
	 input logic ALUSrcE,
	 input logic [1:0] data1ForwardSelector, data2ForwardSelector,
	 input logic [VECTOR_WIDTH-1:0] [WIDTH-1:0] A,B,
	 input logic isvector,
	 output logic [WIDTH-1:0] data2AfterForward, ALUResultE,
	 output logic [VECTOR_WIDTH-1:0] [WIDTH-1:0] Out_v,
	 output logic N, Z, V, C
	 );		
	
	logic [WIDTH-1:0] SrcAE;
	logic [WIDTH-1:0] SrcBE;
	logic N1,N2,Z1,Z2,V1,V2,C1,C2;
	
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
		 N1,
		 Z1,
		 V1,
		 C1 
	);
	
	vector_alu #(WIDTH,VECTOR_WIDTH) ALU_v ( 
    A ,B , ALUControlE ,
    Out_v,
	 N2,
	 Z2,
	 V2,
	 C2
   );

	mux2  #(1) n_ (N1, N2,isvector,N);
	mux2  #(1) z_ (Z1, Z2,isvector,Z);
	mux2  #(1) v_ (V1, V2,isvector,V);
	mux2  #(1) c_ (C1, C2,isvector,C);
	

endmodule

