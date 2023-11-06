`timescale 1 ns / 1 ns
module outdebug();


	parameter WIDTH = 24;
	parameter REGNUM = 16; 
	parameter ADDRESSWIDTH = 4; 
	parameter OPCODEWIDTH = 4;
	parameter INSTRUCTIONWIDTH = 24;
	
	
	logic clock, reset; 
	logic outFlag;
	logic [WIDTH-1:0] out;
	
//	logic writeDataEnableMD,
//	resultSelectorWBD,
//	data2SelectorED,
//	takeBranchE,
//	outFlagIOD;
//	logic [2:0] aluControlED;
//	logic NE2, ZE2, VE2, CE2;
//	logic [OPCODEWIDTH-1:0] opcodeD, opcodeE;
//	logic [1:0] data1ForwardSelectorE, data2ForwardSelectorE;
//	logic stallF, stallD, flushE, flushD;
//	logic [WIDTH-1:0] NewPCF, PCF, PCPlus1F;
//	logic [WIDTH-1:0] MemoryDataAddress, MemoryDataToWrite,
//							MemoryDataOutputM, MemoryDataOutputWB;
//	logic [INSTRUCTIONWIDTH-1:0] InstructionF, InstructionD;
//	logic writeEnableDE,
//			writeDataEnableME,
//			resultSelectorWBE,
//			data2SelectorEE;
//	logic [2:0] aluControlEE;
//	logic [ADDRESSWIDTH-1:0] writeAddressD, 
//							regDestinationAddressD, regDestinationAddressE,
//							reg1AddressD, reg2AddressD, reg1AddressE, reg2AddressE;
//	logic [WIDTH-1:0] reg2FinalE;
//	logic [WIDTH-1:0] inmmediateD, inmmediateE, dataToSaveD;
//	logic [WIDTH-1:0] reg1ContentD, reg2ContentD, reg1ContentE, reg2ContentE;
//	logic writeEnableDM,
//			writeDataEnableMM,
//			resultSelectorWBM,
//			outFlagIOM;
//	logic NE1, ZE1, VE1, CE1;
//	logic [WIDTH-1:0] aluOutputE, aluOutputM;
//	logic [WIDTH-1:0] reg2ContentM, forwardM, forwardWB;
//	logic [ADDRESSWIDTH-1:0] regDestinationAddressM;
//	logic writeEnableDWB,
//			resultSelectorWBWB,
//			data2SelectorEWB;
//	logic [2:0] aluControlEWB;
//	logic [WIDTH-1:0] aluOutputWB;
//	logic [ADDRESSWIDTH-1:0] regDestinationAddressWB;
//	logic [WIDTH-1:0] outputWB;
	logic startIO;
	
	CPU #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH) CPU
	(clock, reset, startIO,
	outFlag,
	out );
//		
//writeEnableDD,
//	writeDataEnableMD,
//	resultSelectorWBD,
//	data2SelectorED,
//	takeBranchE,
//	outFlagIOD,
//	aluControlED,
//	NE2, ZE2, VE2, CE2,
//	opcodeD, opcodeE,
//	data1ForwardSelectorE, data2ForwardSelectorE,
//	stallF, stallD, flushE, flushD,
//	//NewPCF, PCF, PCPlus1F,
//	MemoryDataAddress, MemoryDataToWrite,
//							MemoryDataOutputM, MemoryDataOutputWB,
//	InstructionF, InstructionD,
//	writeEnableDE,
//			writeDataEnableME,
//			resultSelectorWBE,
//			data2SelectorEE,
//	aluControlEE,
//	writeAddressD, 
//							regDestinationAddressD, regDestinationAddressE,
//							reg1AddressD, reg2AddressD, reg1AddressE, reg2AddressE,
//							reg2FinalE,
//							inmmediateD, inmmediateE, dataToSaveD,
//	reg1ContentD, reg2ContentD, reg1ContentE, reg2ContentE,
//	writeEnableDM,
//			writeDataEnableMM,
//			resultSelectorWBM,
//			outFlagIOM,
//	NE1, ZE1, VE1, CE1,
//	aluOutputE, aluOutputM,
//	reg2ContentM, forwardM, forwardWB,
//	regDestinationAddressM,
//	writeEnableDWB,
//			resultSelectorWBWB,
//			data2SelectorEWB,
//	aluControlEWB,
//	aluOutputWB,
//	regDestinationAddressWB,
//	outputWB );

	logic [23:0] i;
	logic [15:0] j;
	
	integer OutFile;
	initial begin
		startIO = 0;
		OutFile = $fopen("C://Users//HP//Desktop//TEC//I-2023//Arqui-I//Repo//jpena_computer_architecture_1_2023//proyecto_2//Procesador//outfile.txt");

		reset = 1;
		clock = 0;
		#10;
		clock = 1;
		#10;
		clock = 0;
		reset = 0;
		#10;
		
		i = 0;
		j = 0;
		while(i<1000) begin // 90000 representa el total de valores que son calculados.
			j = j + 1;
			if (j == 10) begin
				startIO = 1;   
			end
			clock = 1;
			#10
			if(outFlag) begin 
				// fdisplay: Escribe en archivo outFile.txt lo que se encuentra en out.
				$fdisplay(OutFile,"%b", out);
				//$display ($sformatf("Out:  %d",out));
				i+=1;
			end
					
			clock = 0;
			#10;
		end
	end
	
endmodule 