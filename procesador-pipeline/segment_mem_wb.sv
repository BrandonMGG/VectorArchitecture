 module segment_mem_wb (input logic clk, rst,
								input logic MemToReg_in, RegWrite_in,
								input logic [31:0] mem_in, alu_in,
								input logic [3:0] RR3_in,
								output logic MemToReg_out, RegWrite_out,
								output logic [31:0] mem_out, alu_out,
								output logic [3:0] RR3_out);
			
	always_ff@(negedge clk, posedge rst)
		if(rst)
			begin
				MemToReg_out = 0;
				RegWrite_out = 0;
				mem_out = 0;
				alu_out = 0;
				RR3_out = 0;
			end
			
		else 
			begin
				MemToReg_out = MemToReg_in;
				RegWrite_out = RegWrite_in;
				mem_out = mem_in;
				alu_out = alu_in;
				RR3_out = RR3_in;
			end
		
endmodule
