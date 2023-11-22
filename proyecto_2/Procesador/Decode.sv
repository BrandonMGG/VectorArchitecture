/*
	Instruction Decoding Module
	Inputs:
	- reg1Address: address del registro 1 a obtener
	- reg2Address: address del registro 2 a obtener
	- writeAddress: address del registro a sobreescribir
	- inmmediate: 
	- PCPlus8: pc+8
	- dataToSave: datos a escribir
	- clock: 
	- reset: 
	- obtainPCAsR1: bit que indica si obtener el pc como reg1Content 
	- writeEnable: 
	
	Outputs:
	- reg1Content: contenido del reg1
	- reg2Content: contenido del reg2
	
	Params: 
	- REGNUM: number of registers in regfile
	- WIDTH: width of the data
	- ADRESSWIDTH: size of the addresses in regfile
*/
module Decode #(parameter WIDTH = 	24, parameter REGNUM = 8, 
					parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
					parameter INSTRUCTIONWIDTH = 24,parameter VECTOR_WIDTH = 8)
	(input logic [ADDRESSWIDTH-1:0] writeAddress,
	 input logic [WIDTH-1:0] dataToSave, PC,
	 input logic [INSTRUCTIONWIDTH-1:0] instruction,
	 input logic clock, reset, writeEnable,
	 input logic [VECTOR_WIDTH-1:0][WIDTH-1:0] dataToSave_v,
	 input logic isvector_A,vect_esc_A,
	 input logic [2:0] index_A,
	 output logic [WIDTH-1:0] reg1Content, reg2Content, inmediate,
	 output logic [ADDRESSWIDTH-1:0] regDestinationAddress, reg1Address, reg2Address,
	 output logic [OPCODEWIDTH-1:0] opcode,
	 output logic [VECTOR_WIDTH-1:0][WIDTH-1:0] data_out, data_out2,
	 output logic isvector,vect_esc,
	 output logic [2:0] index1
	 );
		
	logic [2:0] index;
	assign reg1Address = instruction[15:12];
	assign reg2Address = instruction[11:8];
	assign regDestinationAddress = instruction[19:16];
	assign inmediate[15:0] = instruction[15:0];
	assign inmediate[WIDTH-1:16] = 0; //Debido a que inm es de 36 bits y la instruccion es solo de 24
	assign opcode = instruction[23:20];
	assign  index = instruction[2:0];
	assign index1 = instruction[2:0];
	//assign isvector = instruction[4];
	//assign vect_esc = instruction[3];
	logic [WIDTH-1:0] reg1Content_s, reg2Content_s, reg1Content_v,reg2Content_v;
	assign isvector = 1'b0;
	assign vect_esc = 1'b0;
	
	regfile #(WIDTH, REGNUM, ADDRESSWIDTH) registerFile (!clock, writeEnable, 
				reg1Address,reg2Address, 
				writeAddress, dataToSave, 
				PC, isvector_A,vect_esc_A,
				reg1Content_s, reg2Content_s
				);
	
	regfile_v #(WIDTH, REGNUM,VECTOR_WIDTH, ADDRESSWIDTH) registerFile_v (!clock, writeEnable, 
				reg1Address,reg2Address, 
				writeAddress, index,//index
				dataToSave,dataToSave_v,PC, isvector_A,vect_esc_A,index_A,
		      data_out, data_out2,		
				reg1Content_v, reg2Content_v
				);
				
	mux4a2  #(WIDTH) sel_reg(reg1Content_s, reg2Content_s,reg1Content_v,reg2Content_v,
				{isvector,vect_esc},
				reg1Content,reg2Content                         // --------- [35:0]
			);			
	
endmodule

