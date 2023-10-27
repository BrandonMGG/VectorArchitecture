module segment_if_id_tb ();

	logic clk, rst;
	logic [31:0] pc_out, instruction;
	logic [31:0] pc;
	logic [1:0] instr_31_30;
	logic [4:0] instr_29_25;
	logic [3:0] instr_27_24, instr_21_18, instr_20_17, instr_7_4, instr_23_20,
					instr_16_13, instr_25_22, instr_24_21, instr_11_8;
	logic [27:0] instr_27_0;

	segment_if_id segment_IF_ID (clk, rst, 
											pc_out, instruction,
											pc, 
											instr_31_30, 
											instr_29_25, 
											instr_27_24, instr_21_18, instr_20_17, instr_7_4, instr_23_20,
											instr_16_13, instr_25_22, instr_24_21, instr_11_8,
											instr_27_0);
	
	initial begin
		
		clk = 0; #1;
		
		// pc_out and instruction test 1:
		pc_out = 1; instruction = 32'b10101111101011111010111110101111; #2;
		
		// pc_out and instruction test 2:
		pc_out = 2; instruction = 32'b11110000000011110000000011111100; #2;
		
		// pc_out and instruction test 3:
		pc_out = 3; instruction = 32'b11111111000011111111000011111111; #2;
		
		// pc_out and instruction test 4:
		pc_out = 4; instruction = 32'b10101111101011111010111110101111; #2;
		
		// pc_out and instruction test 1:
		pc_out = 5; instruction = 32'b10101111101011111010111110101111; #2;
		
		// pc_out and instruction test 2:
		pc_out = 6; instruction = 32'b11110000000011110000000011111100; #2;
		 
	end
	
	always begin
		clk=!clk; #1;
	end
	
endmodule 