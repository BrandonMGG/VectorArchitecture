 module segment_if_id (input logic clk, rst,
								input logic [31:0] pc_out, instruction,
								output logic [31:0] pc,
								output logic [1:0] instr_31_30,
								output logic [4:0] instr_29_25,
								output logic [3:0] instr_27_24, instr_21_18, instr_20_17, instr_7_4, instr_23_20,
														 instr_16_13, instr_25_22, instr_24_21, instr_11_8,
								output logic [27:0] instr_27_0);
			
	always_ff@(negedge clk, posedge rst)
		if(rst)
			begin
				pc = 0;
				instr_31_30 = 0;
				instr_29_25 = 0;
				instr_27_24 = 0;
				instr_21_18 = 0;
				instr_20_17 = 0;
				instr_7_4 = 0;
				instr_23_20 = 0;
				instr_16_13 = 0;
				instr_25_22 = 0;
				instr_24_21 = 0;
				instr_11_8 = 0;
				instr_27_0 = 0;
			end
			
		else 
			begin
				pc = pc_out;
				instr_31_30 = instruction[31:30];
				instr_29_25 = instruction[29:25];
				instr_27_24 = instruction[27:24];
				instr_21_18 = instruction[21:18];
				instr_20_17 = instruction[20:17];
				instr_7_4 = instruction[7:4];
				instr_23_20 = instruction[23:20];
				instr_16_13 = instruction[16:13];
				instr_25_22 = instruction[25:22];
				instr_24_21 = instruction[24:21];
				instr_11_8 = instruction[11:8];
				instr_27_0 = instruction[27:0];
			end
		
endmodule