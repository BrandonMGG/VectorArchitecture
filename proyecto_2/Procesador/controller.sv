module controller #(parameter OPCODEWIDTH = 4)
			(
				output logic writeEnableDD, writeDataEnableMD, resultSelectorWBD, data2SelectorED, outFlagIOD,takeBranchE,
				output logic [2:0] aluControlED,
				input logic [OPCODEWIDTH-1:0] opcodeD,
				input logic [OPCODEWIDTH-1:0] opcodeE,
				input logic NE2, ZE2, VE2, CE2
			);
	
	//                             _______________
	//____________________________/ Control Unit  \_______________
	
	controlunit #(OPCODEWIDTH) controlunit(
		writeEnableDD, //----------------------------------------------------------------- output. Entra a Decode FF
		writeDataEnableMD, //------------------------------------------------------------- output. Entra a Decode FF
		resultSelectorWBD, //------------------------------------------------------------- output. Entra a Decode FF
		data2SelectorED, // -------------------------------------------------------------- output. Entra a Decode FF
		outFlagIOD, // ------------------------------------------------------------------- output Entra a Decode FF
		aluControlED, //------------------------------------------------------------------ output [2:0]. Entra a Decode FF
		opcodeD //------------------------------------------------------------------------ input [3:0]. viene del Decode y entra a Decode FF
	);
	
	
	
	
	//                             _______________
	//____________________________/ Cond Unit     \_______________	
	
	
	condunit #(OPCODEWIDTH) condunit
	(
	 takeBranchE,  // -------------------------------------------------------------------- output
	 opcodeE,      // -------------------------------------------------------------------- input
	 NE2, ZE2, VE2, CE2 //---------------------------------------------------------------- input
	);
			
	
endmodule 