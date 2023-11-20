
// TO-DO: 
// problema con el tamano de la instruccion y de los datos (confirmar solucion)
// eliminar operaciones innecesarias de alu, 
// agregar paso libre a alu para ambos datos
			
 
module CPU_Fetch #(parameter WIDTH = 16, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
				parameter INSTRUCTIONWIDTH = 24)
	(input logic clock, reset,  
					takeBranchE,
					input logic [WIDTH-1:0] NewPCF,
					input logic stallF, stallD, flushD,
					output logic [WIDTH-1:0] PCF, PCD, PCPlus1,
					output logic [INSTRUCTIONWIDTH-1:0] InstructionF, InstructionD
					);
	
		
	// Memory 
	
	logic [WIDTH-1:0] MemoryDataAddress, MemoryDataToWrite,
							MemoryDataOutputM, MemoryDataOutputWB;
	mem #(WIDTH, INSTRUCTIONWIDTH) Memory(clock, writeDataEnableMM, PCF, MemoryDataAddress, 
					MemoryDataToWrite, InstructionF, MemoryDataOutputM);
	
	//-------------------------------------------------------------------------------//
	// Fetch

	Fetch #(WIDTH) Fetch(NewPCF, takeBranchE, clock, reset, !stallF, PCF, PCPlus1);
	
	// Fetch - Decoding FlipFlop
	resetableflipflop  #(INSTRUCTIONWIDTH + WIDTH) FetchFlipFlop(clock, flushD, !stallD, {InstructionF, PCF}, {InstructionD, PCD});
	

endmodule

