module procesador_pipeline(input clk, rst, switchStart);

	// Definicion de la red entre módulos.
	
	// en IF
	logic [31:0] pc_in, pc_out, pc_plus1, instruction;
	
	// en ID
	logic [31:0] pc_id, inm_id, RD1_id, RD2_id, RD3_id;
	logic [27:0] instr_27_0;
	logic [4:0] instr_29_25;
	logic [3:0] instr_27_24, instr_21_18, instr_20_17, instr_7_4, instr_23_20,
			instr_16_13, instr_25_22, instr_24_21, instr_11_8, RR1, RR2, RR3_id;
	logic [2:0] ALUOp_id;
	logic [1:0] instr_31_30, ImmSrc, RegDtn, RegSrc1;
	logic JumpI_id, JumpCI_id, JumpCD_id, MemToReg_id, MemRead_id, MemWrite_id,
			ALUSrc_id, RegWrite_id, RegSrc2;
			
	// en EX
	logic [31:0] pc_plus_inm, pc_ex, alu_op2, alu_res_ex, RD1_ex, RD2_ex, RD3_ex, inm_ex;
	logic [3:0] RR3_ex; 
	logic PCSource;
	logic [2:0] ALUOp_ex;
	logic MemToReg_ex, MemRead_ex, MemWrite_ex, ALUSrc_ex, RegWrite_ex, flagZ,
			JumpI_ex, JumpCI_ex, JumpCD_ex;
	
	// en MEM
	logic MemToReg_mem, MemRead_mem, MemWrite_mem, RegWrite_mem;
	logic [31:0] alu_res_mem, RD3_mem, mem_data_out_mem;
	logic [3:0] RR3_mem;
	
	// en WB
	logic [31:0] result_wb, alu_res_wb, mem_data_out_wb;
	logic [3:0] RR3_wb;
	logic MemToReg_wb, RegWrite_wb;
	
	
	// MODULOS EN IF (sin memoria)
	pc_register pc (clk, ~rst, 1'd1, pc_in, pc_out);
	
	adder add_pc (pc_out, 32'd1, pc_plus1);
	
	mux_2to1 mux_pc (pc_plus1, pc_plus_inm, PCSource, pc_in);
	
	
	// Registro de segmentación IF / ID
	segment_if_id if_id (clk, rst, pc_out, instruction, pc_id, instr_31_30, instr_29_25,
								instr_27_24, instr_21_18, instr_20_17, instr_7_4, instr_23_20,
								instr_16_13, instr_25_22, instr_24_21, instr_11_8, instr_27_0);
	
	
	// MODULOS EM ID
	control_unit control (instr_31_30, instr_29_25, rst, JumpI_id, JumpCI_id, JumpCD_id,
							MemToReg_id, MemRead_id, MemWrite_id, ALUOp_id, ALUSrc_id, RegWrite_id,
							ImmSrc, RegDtn, RegSrc2, RegSrc1);

	
	mux_4to1 #(.N(4)) mux_RR1 (instr_27_24, instr_21_18, instr_20_17, instr_7_4, RegSrc1, RR1);
	
	mux_2to1 #(.N(4)) mux_RR2 (instr_23_20, instr_16_13, RegSrc2, RR2);
	
	mux_4to1 #(.N(4)) mux_RR3 (instr_25_22, instr_24_21, instr_11_8, 4'd0, RegDtn, RR3_id);
	
	sign_extend sign_extend (instr_27_0, ImmSrc, inm_id);
	
	register_file register_file (RR1, RR2, RR3_id, RR3_wb, result_wb, RegWrite_wb, clk, rst, RD1_id, RD2_id, RD3_id);
	
	
	// Registro de segmentación ID / EX
	segment_id_ex id_ex (JumpI_id, JumpCI_id, JumpCD_id, clk, rst, MemToReg_id, MemRead_id, MemWrite_id, ALUOp_id, ALUSrc_id, RegWrite_id,
							pc_id, RD1_id, RD2_id, RD3_id, RR3_id, inm_id,
							MemToReg_ex, MemRead_ex, MemWrite_ex, ALUOp_ex, ALUSrc_ex, RegWrite_ex,
							pc_ex, RD1_ex, RD2_ex, RD3_ex, RR3_ex, inm_ex,
							JumpI_ex, JumpCI_ex, JumpCD_ex);
							
	
	// MODULOS EN EX
	adder add_inm (pc_ex, inm_ex, pc_plus_inm);
	
	mux_2to1 mux_alu (RD2_ex, inm_ex, ALUSrc_ex, alu_op2);
	
	alu alu (RD1_ex, alu_op2, ALUOp_ex, alu_res_ex, flagZ);
	
	jump_unit jump_unit (flagZ, JumpCD_ex, JumpCI_ex, JumpI_ex, PCSource);
	
	
	// Registro de segmentación EX / MEM
	segment_ex_mem ex_mem (clk, rst, MemToReg_ex, MemRead_ex, MemWrite_ex, RegWrite_ex,
					alu_res_ex, RD3_ex, RR3_ex,
					MemToReg_mem, MemRead_mem, MemWrite_mem, RegWrite_mem,
					alu_res_mem, RD3_mem, RR3_mem);
							
	
	// MODULO MEMORIA
	memoryAccess memory (clk, MemWrite_mem, switchStart, pc_out,alu_res_mem, 
								RD3_mem, mem_data_out_mem, instruction);
	
	
	// Registro de segmentación MEM / WB
	segment_mem_wb mem_wb (clk, rst, MemToReg_mem, RegWrite_mem, 
					mem_data_out_mem, alu_res_mem, RR3_mem,
					MemToReg_wb, RegWrite_wb, mem_data_out_wb, alu_res_wb, RR3_wb);
	
	// MODULOS EN WB
	mux_2to1 mux_wb (alu_res_wb, mem_data_out_wb, MemToReg_wb, result_wb);
				

endmodule
