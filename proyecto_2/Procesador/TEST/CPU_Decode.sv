
// TO-DO: 
// problema con el tamano de la instruccion y de los datos (confirmar solucion)
// eliminar operaciones innecesarias de alu, 
// agregar paso libre a alu para ambos datos
			
 
module CPU_Decode #(parameter WIDTH = 16, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
				parameter INSTRUCTIONWIDTH = 24)
	(input logic clock, reset, 
					PCSelectorFD, 
					obtainPCAsR1DD, writeEnableDD,
					writeDataEnableMD,
					resultSelectorWBD,
					data2SelectorED,
					input logic [ADDRESSWIDTH-1:0] writeAddressD,
					input logic [2:0] aluControlED,
					input logic [INSTRUCTIONWIDTH-1:0] InstructionD,
					input logic [WIDTH-1:0] PCD,
					input logic [WIDTH-1:0] dataToSaveD,
					output logic [OPCODEWIDTH-1:0] opcodeD,
					output logic [ADDRESSWIDTH-1:0] regDestinationAddressD, reg1AddressD, reg2AddressD,
					output logic [WIDTH-1:0] inmmediateE,
					output logic [WIDTH-1:0] reg1ContentD, reg2ContentD
					);
	
	logic flushE;
	
	
	// Decoder
	
	logic PCSelectorFE, 
			writeEnableDE,
			writeDataEnableME,
			resultSelectorWBE,
			data2SelectorEE;
	logic [2:0] aluControlEE;	

	
	
	logic [ADDRESSWIDTH-1:0] regDestinationAddressE,
							reg1AddressE, reg2AddressE;
	logic [WIDTH-1:0] inmmediateD;
	logic [WIDTH-1:0] reg1ContentE, reg2ContentE;
	
	Decode #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) Decode
	( writeAddressD,
	  dataToSaveD, PCD,
	  InstructionD,
	  clock, reset, obtainPCAsR1DD, writeEnableDD,
	  reg1ContentD, reg2ContentD, inmmediateD,
	  regDestinationAddressD, reg1AddressD, reg2AddressD,
	  opcodeD
	 );
	 
	 
	 // Decode - Execution Flip-Flop
	 
	 resetableflipflop  #(3*ADDRESSWIDTH+3*WIDTH+5+3) DecodeFlipFlop(clock, flushE, 1'b1,
	 {reg1ContentD, reg2ContentD, regDestinationAddressD, inmmediateD, reg1AddressD, reg2AddressD,
			PCSelectorFD, 
			writeEnableDD,
			writeDataEnableMD,
			resultSelectorWBD,
			data2SelectorED,
	      aluControlED}, 
	 {reg1ContentE, reg2ContentE, regDestinationAddressE, inmmediateE, reg1AddressE, reg2AddressE,
			PCSelectorFE, 
			writeEnableDE,
			writeDataEnableME,
			resultSelectorWBE,
			data2SelectorEE,
	      aluControlEE});

	 
	

endmodule

