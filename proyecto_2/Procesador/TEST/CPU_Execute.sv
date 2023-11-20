
// TO-DO: 
// problema con el tamano de la instruccion y de los datos (confirmar solucion)
// eliminar operaciones innecesarias de alu, 
// agregar paso libre a alu para ambos datos
			
 
module CPU_Execute #(parameter WIDTH = 16, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
				parameter INSTRUCTIONWIDTH = 24)
	(input logic clock, 
					input logic [2:0] aluControlEE,
					input logic data2SelectorEE,
					input logic [1:0] data1ForwardSelectorE, data2ForwardSelectorE,
					input logic [WIDTH-1:0] reg1ContentE, reg2ContentE, inmmediateE, forwardM, forwardWB,
					output logic [WIDTH-1:0] aluOutputE,
					output logic N, Z, V, C
					);
						
	logic stallF, stallD, flushE, flushD;
	
	
	//Execute
	
	logic PCSelectorFM, 
			writeEnableDM,
			writeDataEnableMM,
			resultSelectorWBM;

	
	logic [WIDTH-1:0] aluOutputM;
	logic [WIDTH-1:0] reg2ContentM;
	logic [ADDRESSWIDTH-1:0] regDestinationAddressM;
	
	
	Execute #(WIDTH) Execute
	(reg1ContentE, reg2ContentE, inmmediateE, forwardM, forwardWB,
	 aluControlEE,
	 data2SelectorEE,
	 data1ForwardSelectorE, data2ForwardSelectorE,
	 aluOutputE,
	 N, Z, V, C
	 );		
	
	
	 // Execution - Memory Flip-Flop
	 
	 
	 resetableflipflop  #(2*WIDTH+ADDRESSWIDTH+4) ExecuteFlipFlop(clock, reset, 1'b1,
	 {aluOutputE, reg2ContentE, regDestinationAddressE,
			PCSelectorFE, 
			writeEnableDE,
			writeDataEnableME,
			resultSelectorWBE}, 
	 {aluOutputM, reg2ContentM, regDestinationAddressM,
			PCSelectorFM, 
			writeEnableDM,
			writeDataEnableMM,
			resultSelectorWBM});
	 
   //-------------------------------------------------------------------------------//

endmodule

