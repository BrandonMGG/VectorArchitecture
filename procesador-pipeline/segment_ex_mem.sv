 module segment_ex_mem (input logic clk, rst,
								input logic MemToReg_in, MemRead_in, MemWrite_in, RegWrite_in,
								input logic [31:0] alu_in, RD3_in, 
								input logic [3:0] RR3_in,
								output logic MemToReg_out, MemRead_out, MemWrite_out, RegWrite_out,
								output logic [31:0] alu_out, RD3_out, 
								output logic [3:0] RR3_out);
			
	always_ff@(negedge clk, posedge rst)
		if(rst)
			begin
				MemToReg_out = 0;
				MemRead_out = 0;
				MemWrite_out = 0;
				RegWrite_out = 0;
				alu_out = 0;
				RD3_out = 0;
				RR3_out = 0;
			end
			
		else 
			begin
				MemToReg_out = MemToReg_in;
				MemRead_out = MemRead_in;
				MemWrite_out = MemWrite_in;
				RegWrite_out = RegWrite_in;
				alu_out = alu_in;
				RD3_out = RD3_in;
				RR3_out = RR3_in;
			end
		
endmodule