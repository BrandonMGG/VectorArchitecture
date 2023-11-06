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
					parameter ADDRESSWIDTH = 3, parameter OPCODEWIDTH = 4,
					parameter INSTRUCTIONWIDTH = 24)
	(input logic [ADDRESSWIDTH-1:0] writeAddress,
	 input logic [WIDTH-1:0] dataToSave, PC,
	 input logic [INSTRUCTIONWIDTH-1:0] instruction,
	 input logic clock, reset, writeEnable,
	 output logic [WIDTH-1:0] reg1Content, reg2Content, inmediate,
	 output logic [ADDRESSWIDTH-1:0] regDestinationAddress, reg1Address, reg2Address,
	 output logic [OPCODEWIDTH-1:0] opcode
	 );
		
	
	assign reg1Address = instruction[15:12];
	assign reg2Address = instruction[11:8];
	assign regDestinationAddress = instruction[19:16];
	assign inmediate[15:0] = instruction[15:0];
	assign inmediate[WIDTH-1:16] = 0; //Debido a que inm es de 36 bits y la instruccion es solo de 24
	assign opcode = instruction[23:20];
		
	
	regfile #(WIDTH, REGNUM, ADDRESSWIDTH) registerFile (!clock, writeEnable, 
				reg1Address,reg2Address, 
				writeAddress, dataToSave, 
				PC, 
				reg1Content, reg2Content
				);

endmodule

