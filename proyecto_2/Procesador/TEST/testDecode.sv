module testDecode
				#(parameter WIDTH = 16, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
				parameter INSTRUCTIONWIDTH = 24)();

	logic clk, reset, PCSelectorFD, obtainPCAsR1DD, writeEnableDD,	writeDataEnableMD, resultSelectorWBD, data2SelectorED;
	logic [ADDRESSWIDTH-1:0] writeAddressD;
	logic [2:0] aluControlED;
	logic [INSTRUCTIONWIDTH-1:0] InstructionD;
	logic [WIDTH-1:0] PCD;
	logic [WIDTH-1:0] dataToSaveD;
	logic [OPCODEWIDTH-1:0] opcodeD;
	logic [ADDRESSWIDTH-1:0] regDestinationAddressD, reg1AddressD, reg2AddressD;
	logic [WIDTH-1:0] inmmediateE;
	logic [WIDTH-1:0] reg1ContentD, reg2ContentD;
	
	CPU_Decode testDecode(clk, reset, 
					PCSelectorFD, 
					obtainPCAsR1DD, writeEnableDD,
					writeDataEnableMD,
					resultSelectorWBD,
					data2SelectorED,
					writeAddressD,
					aluControlED,
					InstructionD,
					PCD,
					dataToSaveD,
					opcodeD,
					regDestinationAddressD, reg1AddressD, reg2AddressD,
					inmmediateE,
					reg1ContentD, reg2ContentD
					);
								
								
	//Creacion de un reloj
	always begin
		clk = 0; #5; clk=~clk; #5;
	end
	
	initial begin	
		#5;
		
		PCD = 16'd0; // 1 - 1 = 0
		
		// Ejemplo 1: SUB R0, R15, R15
		InstructionD = 24'b010000001111111100000000; obtainPCAsR1DD = 0; writeEnableDD = 0;
		#10;
		
		// Execution -> R15 - R15 (1 - 1 = 0)
		data2SelectorED = 0; dataToSaveD = 16'd1;
		#10;
		
		// Memory
		#10;
		
		// Write back
		writeAddressD = 16'd0;
		resultSelectorWBD = 0; writeDataEnableMD = 0;
		writeEnableDD = 1;
		#6;
		writeEnableDD = 0;
		#4;

		// Ejemplo 2: ADD R1, R0, R0
		InstructionD = 24'b001100010000000000000000; obtainPCAsR1DD = 0; writeEnableDD = 0;
		#10;
		
	end
																
endmodule
