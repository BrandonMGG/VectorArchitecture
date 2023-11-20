module testControlUnit
				#(parameter WIDTH = 16, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
				parameter INSTRUCTIONWIDTH = 24)();

	logic writeEnableDD, writeDataEnableMD, resultSelectorWBD, data2SelectorED, outFlag;
	logic [2:0] aluControlED;
	logic [OPCODEWIDTH-1:0] opcodeD;

	logic writeEnableDDExpected, writeDataEnableMDExpected, resultSelectorWBDExpected, data2SelectorEDExpected, outFlagExpected;
	logic [2:0] aluControlEDExpected;
	
	controlunit testControlUnit(writeEnableDD, writeDataEnableMD, 
					resultSelectorWBD,
					data2SelectorED,
					outFlag,
					aluControlED,
					opcodeD
					);
								
								
	initial begin	
		
		$display ("============= Unit Control =============");
		
		// NOP
		opcodeD = 4'b0000;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 0;
		aluControlEDExpected = 3'b000;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED == data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display ($sformatf("exito para opcodeD = %b", opcodeD));
		else $error($sformatf("fallo para opcodeD = %b", opcodeD));

		// Store Byte
		opcodeD = 4'b0001;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 1'bx;
		aluControlEDExpected = 3'b110;
		writeDataEnableMDExpected = 1;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED == data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display ($sformatf("exito para opcodeD = %b", opcodeD));
		else $error($sformatf("fallo para opcodeD = %b", opcodeD));
		
		// MOVI
		opcodeD = 4'b0010;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 1;
		aluControlEDExpected = 3'b111;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED == data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display ($sformatf("exito para opcodeD = %b", opcodeD));
		else $error($sformatf("fallo para opcodeD = %b", opcodeD));
		
		// MOVI
		opcodeD = 4'b0011;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 1'bx;
		aluControlEDExpected = 3'b110;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED == data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display ($sformatf("exito para opcodeD = %b", opcodeD));
		else $error($sformatf("fallo para opcodeD = %b", opcodeD));
		
		// OUT
		opcodeD = 4'b0100;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 1'bx;
		aluControlEDExpected = 3'b110;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 1;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED == data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display ($sformatf("exito para opcodeD = %b", opcodeD));
		else $error($sformatf("fallo para opcodeD = %b", opcodeD));
		
		// ADD
		opcodeD = 4'b0101;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 0;
		aluControlEDExpected = 3'b000;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;

		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED == data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display ($sformatf("exito para opcodeD = %b", opcodeD));
		else $error($sformatf("fallo para opcodeD = %b", opcodeD));
		
		// SUBtract
		opcodeD = 4'b0110;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 0;
		aluControlEDExpected = 3'b001;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED == data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display ($sformatf("exito para opcodeD = %b", opcodeD));
		else $error($sformatf("fallo para opcodeD = %b", opcodeD));
		
		// Load Byte
		opcodeD = 4'b0111;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 1'bx;
		aluControlEDExpected = 3'b110;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 1;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED == data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display ($sformatf("exito para opcodeD = %b", opcodeD));
		else $error($sformatf("fallo para opcodeD = %b", opcodeD));
		
		// OR
		opcodeD = 4'b1000;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 0;
		aluControlEDExpected = 3'b011;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED == data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display ($sformatf("exito para opcodeD = %b", opcodeD));
		else $error($sformatf("fallo para opcodeD = %b", opcodeD));
		
		// SHIFTL
		opcodeD = 4'b1001;
		writeEnableDDExpected = 1;
		data2SelectorEDExpected = 0;
		aluControlEDExpected = 3'b101;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED == data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display ($sformatf("exito para opcodeD = %b", opcodeD));
		else $error($sformatf("fallo para opcodeD = %b", opcodeD));
		
		// Compare
		opcodeD = 4'b1010;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 0;
		aluControlEDExpected = 3'b001;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;

		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED == data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display ($sformatf("exito para opcodeD = %b", opcodeD));
		else $error($sformatf("fallo para opcodeD = %b", opcodeD));
		
		// Branch =
		opcodeD = 4'b1011;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 1;
		aluControlEDExpected = 3'b111;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED == data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display ($sformatf("exito para opcodeD = %b", opcodeD));
		else $error($sformatf("fallo para opcodeD = %b", opcodeD));
		
		// BranchReg
		opcodeD = 4'b1100;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 1'bx;
		aluControlEDExpected = 3'b110;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;

		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED == data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display ($sformatf("exito para opcodeD = %b", opcodeD));
		else $error($sformatf("fallo para opcodeD = %b", opcodeD));
		
		// Branch <
		opcodeD = 4'b1101;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 1;
		aluControlEDExpected = 3'b111;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;

		assert (writeEnableDD == writeEnableDDExpected && writeDataEnableMD == writeDataEnableMDExpected &&
					resultSelectorWBD == resultSelectorWBDExpected && data2SelectorED == data2SelectorEDExpected &&
					outFlag == outFlagExpected && aluControlED == aluControlEDExpected) 
					$display ($sformatf("exito para opcodeD = %b", opcodeD));
		else $error($sformatf("fallo para opcodeD = %b", opcodeD));
		
		// Jump
		opcodeD = 4'b1111;
		writeEnableDDExpected = 0;
		data2SelectorEDExpected = 1;
		aluControlEDExpected = 3'b111;
		writeDataEnableMDExpected = 0;
		resultSelectorWBDExpected = 0;
		outFlagExpected = 0;
		#10;
		
	end
																
endmodule
