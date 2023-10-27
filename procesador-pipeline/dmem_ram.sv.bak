module dmem_ram(input logic clk, we,
				input logic [31:0] address, wd,
				output logic [31:0] rd);
	
	reg [31:0] dmem_RAM[0:129599];
	
	// Memory meant to be read.
	always_ff @(negedge clk)
		begin
			if (address >= 'd0 && address <= 'd129599)
				rd = {31'b0, dmem_RAM[address]};
			else
				rd = 32'b0;
		end
	
	// Memory meant to be written.
	always_ff @(posedge clk)
		begin
			if (we) 
				begin
					if (address >= 'd0 && address <= 'd129599)
						dmem_RAM[address] <= wd;
						rd = rd;
						$writememh("C:/altera/14.1/procesador_pipeline/imageOutput.txt", dmem_RAM);
				end
		end
		
		

endmodule 