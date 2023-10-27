module memoryController (input logic clk, we, switchStart,
					 input logic [31:0] pc, address, wd,
					 output logic [31:0] rd, instruction
);
						 
	logic [31:0] mapAddressROM, mapAddressRAM, mapAddressInstructions, romData, ramData, instructionData;
						 
	dmem_ram ram (clk, we, mapAddressRAM, wd, ramData);
	dmem_rom rom (mapAddressROM, romData);
	imem imem_rom (mapAddressInstructions, instructionData);
	
	always_latch
		begin
		
			// Reading instructions.
			if (pc >= 'd0 && pc < 'd399)
				begin
					mapAddressInstructions = pc;
					instruction = instructionData;
				end
		
			// Reading data from Rom.
			if (address >= 'd400 && address < 'd8500)
				begin
					mapAddressROM = address - 'd400;
					rd = romData;
				end
			
			// Reading or writing from Ram.
			else if (address >= 'd8500 && address < 'd138100)
				begin
					mapAddressRAM = address - 'd8500;
					rd = ramData;
				end
				
			// Case if nothing happens.
			else
				begin
					mapAddressRAM = 32'b0;
					mapAddressROM = 32'b0;
					rd = 32'b0;
				end
		end
						 
endmodule 