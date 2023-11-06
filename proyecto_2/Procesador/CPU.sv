
module CPU #(parameter WIDTH = 24, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
				parameter INSTRUCTIONWIDTH = 24)
	(
	input logic clock, reset, startIO, 
	output logic outFlagIOE,
	output logic [WIDTH-1:0] out //,
	);
	
	/*
	output logic writeEnableDD,
					 writeDataEnableMD,
					 resultSelectorWBD,
					 data2SelectorED,
					 takeBranchE,
					 outFlagIOD,
	output logic [2:0] aluControlED,
	output logic NE2, ZE2, VE2, CE2,
	output logic [OPCODEWIDTH-1:0] opcodeD, opcodeE, 												// [3:0]
	output logic [1:0] data1ForwardSelectorE, data2ForwardSelectorE, 							// [1:0] For muxes
	output logic stallF, stallD, flushE, flushD, 													// Hazard
	//output logic [WIDTH-1:0] F, PCF, PCPlus1F, 												//Fetch stage buses. [35:0]
	output logic [WIDTH-1:0] MemoryDataAddress, MemoryDataToWrite,
							MemoryDataOutputM, MemoryDataOutputWB,
	output logic [INSTRUCTIONWIDTH-1:0] InstructionF, InstructionD, 							// [23:0]
	output logic writeEnableDE, 
					 writeDataEnableME,
					 resultSelectorWBE, 
					 data2SelectorEE,
	output logic [2:0] aluControlEE, 																	// Alu selector [2:0] (3 bits => 8 ops max)
	output logic [ADDRESSWIDTH-1:0] writeAddressD, 													// (?) [3:0]
							regDestinationAddressD, regDestinationAddressE,                   // (?) [3:0]
							reg1AddressD, reg2AddressD, reg1AddressE, reg2AddressE,           // (?) [3:0]
	output logic [WIDTH-1:0] reg2FinalE, 																//[35:0]
	output logic [WIDTH-1:0] inmmediateD, inmmediateE, dataToSaveD, 							//[35:0]
	output logic [WIDTH-1:0] reg1ContentD, reg2ContentD, reg1ContentE, reg2ContentE, 	//[35:0]
	output logic writeEnableDM,
			writeDataEnableMM,
			resultSelectorWBM,	
			outFlagIOM,
	output logic NE1, ZE1, VE1, CE1,
	output logic [WIDTH-1:0] aluOutputE, aluOutputM,                                    //[35:0]
	output logic [WIDTH-1:0] reg2ContentM, forwardM, forwardWB,                         //[35:0]
	output logic [ADDRESSWIDTH-1:0] regDestinationAddressM,										//[3:0]
	output logic writeEnableDWB,
					 resultSelectorWBWB,
					 data2SelectorEWB,
	output logic [2:0] aluControlEWB, 																	// ALU selector [2:0] (3 bits => 8 ops max)
	output logic [WIDTH-1:0] aluOutputWB,  															//[35:0]
	output logic [ADDRESSWIDTH-1:0] regDestinationAddressWB,  									//[3:0]
	output logic [WIDTH-1:0] outputWB                      									//[35:0]
	);
	*/
	
	
	logic writeEnableDD, writeDataEnableMD, resultSelectorWBD, data2SelectorED, outFlagIOD;
	
	logic [2:0] aluControlED;
	
	logic [OPCODEWIDTH-1:0] opcodeD;	
	
	logic takeBranchE;
	
	logic [OPCODEWIDTH-1:0] opcodeE;
	
	logic NE2, ZE2, VE2, CE2;
	
	logic [1:0] data1ForwardSelectorE, data2ForwardSelectorE;
	
	logic stallF, stallD, flushE, flushD;
	
	logic [WIDTH-1:0] NewPCF, PCF, PCPlus1F;
	
	
	logic [WIDTH-1:0] MemoryDataAddress, MemoryDataToWrite, MemoryDataOutputM, MemoryDataOutputWB;
	//logic [WIDTH-1:0] MemoryDataAddress, MemoryDataOutputM, MemoryDataOutputWB;
	//logic [8-1:0] MemoryDataToWrite;
	
	logic [INSTRUCTIONWIDTH-1:0] InstructionF, InstructionD;
	
	logic writeEnableDE, writeDataEnableME, resultSelectorWBE, data2SelectorEE;
	
	logic [2:0] aluControlEE;
	
	logic [ADDRESSWIDTH-1:0] writeAddressD, regDestinationAddressD, regDestinationAddressE,reg1AddressD, reg2AddressD, reg1AddressE, reg2AddressE;
	
	logic [WIDTH-1:0] reg2FinalE;
	
	logic [WIDTH-1:0] inmmediateD, inmmediateE, dataToSaveD;
	
	logic [WIDTH-1:0] reg1ContentD, reg2ContentD, reg1ContentE, reg2ContentE;
	
	logic writeEnableDM, writeDataEnableMM, resultSelectorWBM,	outFlagIOM;
	
	logic NE1, ZE1, VE1, CE1;
	
	logic [WIDTH-1:0] aluOutputE, aluOutputM;
	
	logic [WIDTH-1:0] reg2ContentM, forwardM, forwardWB;
	
	
	
	logic [ADDRESSWIDTH-1:0] regDestinationAddressM;
	
	logic writeEnableDWB, resultSelectorWBWB, data2SelectorEWB;
	
	logic [2:0] aluControlEWB;
	
	logic [WIDTH-1:0] aluOutputWB;
	
	logic [ADDRESSWIDTH-1:0] regDestinationAddressWB;
	
	logic [WIDTH-1:0] outputWB;
	
	

	
	
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
	(takeBranchE, // -------------------------------------------------------------------- output
	 opcodeE,     // -------------------------------------------------------------------- input
	NE2, ZE2, VE2, CE2 //---------------------------------------------------------------- input
	);	
		
	
		
	
	/*
	
	//                             ____________
	//____________________________/ Controller \_______________
	//                            \____________/							
		
	controller #(OPCODEWIDTH) 
		Controller(
					  writeEnableDD, //-------------------------------------------------------------------- output. Entra a Decode FF
					  writeDataEnableMD, //---------------------------------------------------------------- output. Entra a Decode FF
					  resultSelectorWBD, //---------------------------------------------------------------- output. Entra a Decode FF
					  data2SelectorED, // ----------------------------------------------------------------- output. Entra a Decode FF
					  outFlagIOD,// ----------------------------------------------------------------------- output Entra a Decode FF
					  takeBranchE, // --------------------------------------------------------------------- output
					  aluControlED, //--------------------------------------------------------------------- output [2:0]. Entra a Decode FF
					  opcodeD, opcodeE,  // --------------------------------------------------------------- input
					  NE2, ZE2, VE2, CE2 //---------------------------------------------------------------- input
					  );		
				
	*/
	

	
	//                             ______________
	//____________________________/ Hazards Unit \_______________
	//                            \______________/	
		
		
	hazardsUnitsv #(WIDTH, ADDRESSWIDTH) HazardsUnit(
		writeEnableDWB, writeEnableDM, resultSelectorWBE, takeBranchE, // ----------------- Inputs
		regDestinationAddressM, regDestinationAddressWB, regDestinationAddressE, // ------- Input [3:0]
		reg1AddressE, reg2AddressE, reg1AddressD, reg2AddressD, //------------------------- Input [3:0]
		
		data1ForwardSelectorE, data2ForwardSelectorE, 	//--------------------------------- output [2:0]
		stallF, stallD, flushE, flushD);						//--------------------------------- output	
	
	
	//                             _________
	//____________________________/  Memory \_______________			
	//                            \_________/	
	
	topMemory #(WIDTH, INSTRUCTIONWIDTH,8) 
		Memory(clock, writeDataEnableMM, startIO, // --------------------------------------- Input. 1 bit
				 MemoryDataAddress, MemoryDataToWrite, // ------------------------------- INPUT [35:0]. PCF(a1), MemoryDataAddress(a2), MemoryDataToWrite(wd)
				 // ------------------------------------------------------------ output. [23:0]. InstructionF(rd1)
		       MemoryDataOutputM); // ------------------------------------------------------ output [23:0]. MemoryDataOutputM(rd2)
	
	//logic [23:0] PCTemp;
	
	// Instruction MEMORY ROM
	instMem #(24,256)
		instMem(PCF,InstructionF);
	
	
	//                             ____________
	//____________________________/    Fetch   \_______________		
	//                            \____________/	
	

	Fetch #(WIDTH) Fetch(NewPCF, 			// ------------------------------------------------ [35:0]. Input
								takeBranchE,   // ------------------------------------------------ PCSelector. input
								clock, reset,  // ------------------------------------------------ Input
								!stallF,       // ------------------------------------------------ enable input
								PCF,            // ------------------------------------------------ [35:0] output
								PCPlus1F);		// ------------------------------------------------ [35:0] output
	
	
	//                             ________________________________
	//____________________________/     FromFetch2DecodeFlipFlop   \_______________		
	// Fetch - Decoding FlipFlop
	resetableflipflop  #(INSTRUCTIONWIDTH) // INSTRUCTIONWIDTH = 24
		FromFetch2DecodeFlipFlop(           
			clock, flushD, !stallD,           // --------------------------------------------- INPUT [1]
			{InstructionF},  				      // ---------------------------------------------  INPUT (d)  [23:0]
			{InstructionD});                 // ---------------------------------------------  OUTPUT (q) [23:0]
	

	//                             ____________
	//____________________________/   Decoder  \_______________		
	//                            \____________/	
		
	Decode #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) 
		Decode 																								 
			(writeAddressD,// -------------------------------------------------------------- INPUT [3:0]
			dataToSaveD, PCPlus1F, // ------------------------------------------------------ INPUT [35:0]. PCPlus1F(PC)
			InstructionD,	// -------------------------------------------------------------- INPUT [24:0]
			clock, reset, writeEnableDWB,	// -----------------------------------------------	INPUT [0]
			reg1ContentD, reg2ContentD, inmmediateD, // ------------------------------------ OUTPUT [35:0]
			regDestinationAddressD, reg1AddressD, reg2AddressD,  // ------------------------ OUTPUT [3:0]
			opcodeD	// -------------------------------------------------------------------- OUTPUT [3:0]
			);
	 
	 	 
	//                             _____________________
	//____________________________/ FromDec2ExeFlipFlop \_______________		 

	 
	 resetableflipflop  #(120) // 3*4 + 3*24+4+3+4+4+1 = 100
		FromDec2ExeFlipFlop(
			clock, flushE, 1'b1, 
			
			{	
				reg1ContentD, reg2ContentD, regDestinationAddressD, // ------- [23:0] 
				inmmediateD, // ---------------------------------------------- [23:0]                                       
				reg1AddressD, reg2AddressD, // ------------------------------- [3:0]
				writeEnableDD,                                            
				writeDataEnableMD,
				resultSelectorWBD,
				data2SelectorED,
				aluControlED, // --------------------------------------------- [2:0]
				opcodeD,      // --------------------------------------------- [3:0]
				NE1, ZE1, VE1, CE1, outFlagIOD // ---------------------------- [0]
			}, // ----------------------------------------------------------- INPUT[119:0] 																			
			
			{
				reg1ContentE, reg2ContentE, regDestinationAddressE, 
				inmmediateE, 
				reg1AddressE, 
				reg2AddressE,
				writeEnableDE,
				writeDataEnableME,
				resultSelectorWBE,
				data2SelectorEE,
				aluControlEE,
				opcodeE,
				NE2, ZE2, VE2, CE2, outFlagIOE}
			); // ----------------------------------------------------------- OUTPUT [135:0]

		
	
	//                             ____________
	//____________________________/   Execute  \_______________
	//                            \____________/	



	Execute #(WIDTH) 
	Execute
		(reg1ContentE, reg2ContentE, inmmediateE, forwardM, forwardWB, // ------------ [35:0]
		aluControlEE, // ------------------------------------------------------------- [2:0]
		data2SelectorEE, //----------------------------------------------------------- [0]
		data1ForwardSelectorE, data2ForwardSelectorE, // ----------------------------- [1:0]
		reg2FinalE, aluOutputE, // --------------------------------------------------- [35:0]
		NE1, ZE1, VE1, CE1      // --------------------------------------------------- [0]
		);		
	


	 assign NewPCF = aluOutputE;
	 assign out = aluOutputE;


	//                             _____________________
	//____________________________/ FromExe2MemFlipFlop \_______________		 
	 
	 
	 resetableflipflop  #(55) // 55
		FromExe2MemFlipFlop(
			clock, reset, 1'b1,
			
			{
				aluOutputE, reg2FinalE, // ----------------------------------- [23:0]
				regDestinationAddressE, // ----------------------------------- [3:0]
				writeEnableDE,          // ----------------------------------- [0]
				writeDataEnableME,      // ----------------------------------- [0]
				resultSelectorWBE       // ----------------------------------- [0]
			}, // ----------------------------------------------------------- INPUT[54:0]
			
			{
				aluOutputM, reg2ContentM, // --------------------------------- [35:0]
				regDestinationAddressM,   // --------------------------------- [3:0]
				writeEnableDM,            // --------------------------------- [0]
				writeDataEnableMM,        // --------------------------------- [0]
				resultSelectorWBM         // --------------------------------- [0]
			}  
			); // ----------------------------------------------------------- OUTPUT [54:0]
	    

	//                             ____________
	//____________________________/   Memory   \_______________	
	//                            \____________/

	
	
	assign MemoryDataToWrite = reg2ContentM; // --------------------------- [23:0]
	assign MemoryDataAddress = aluOutputM;   // --------------------------- [23:0]
	assign forwardM = aluOutputM;            // --------------------------- [23:0]

	//                             ________________________
	//____________________________/ FromMem2DecodeFlipFlop \_______________		 

	resetableflipflop  #(54) // 54
		FromMem2DecodeFlipFlop(
			clock, reset, 1'b1,
			
			{
				aluOutputM, MemoryDataOutputM, // --------------------------- [23:0]
				regDestinationAddressM,        // --------------------------- [3:0]
				writeEnableDM,                 // --------------------------- [0]
				resultSelectorWBM              // --------------------------- [0]
			}, // ---------------------------------------------------------- INPUT[53:0]
			
			{
				aluOutputWB, MemoryDataOutputWB, // ------------------------- [35:0]
				regDestinationAddressWB,         // ------------------------- [3:0]
				writeEnableDWB,                  // ------------------------- [0]
				resultSelectorWBWB               // ------------------------- [0]
			} // ----------------------------------------------------------- OUTPUT [53:0]
			); 

    //-------------------------------------------------------------------------------//
	 
	 

	 
	 
	//                             _____________
	//____________________________/ Write Back  \_______________		 
	//                            \_____________/
	 
	 mux2  #(WIDTH) 
		writeBack
			(
				aluOutputWB, MemoryDataOutputWB, // --------- [35:0]
				resultSelectorWBWB,              // --------- [0]
				outputWB                         // --------- [35:0]
			);
	 
	 
	 assign writeAddressD = regDestinationAddressWB; // [4:0]
	 assign dataToSaveD = outputWB;//------------------ [35:0]
	 assign forwardWB = outputWB; // ------------------ [35:0]
	 
	 
	 
	 initial begin 
	 resultSelectorWBE = 0;
	 end
	 
	 
endmodule

