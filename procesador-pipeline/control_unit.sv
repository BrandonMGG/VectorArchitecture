 module control_unit (input logic [1:0] instruction_type, 
								input logic [4:0] func,
								input logic rst,
								output logic JumpI, JumpCI, JumpCD, MemToReg, MemRead, MemWrite, 
								output logic [2:0] ALUOp,
								output logic ALUSrc, RegWrite,
								output logic [1:0] ImmSrc, RegDtn, 
								output logic RegSrc2, 
								output logic [1:0] RegSrc1);
			
	always_latch
	begin
		if(rst)
			begin
				JumpI = 0;
				JumpCI = 0;
				JumpCD = 0;
				MemToReg = 0;
				MemRead = 0;
				MemWrite = 0;
				ALUOp = 0;
				ALUSrc = 0;
				RegWrite = 0;
				ImmSrc = 0;
				RegDtn = 0;
				RegSrc2 = 0;
				RegSrc1 = 0;
			end
		
		// Instrucciones de Datos sin inmediato:
		if (instruction_type == 2'b10 && func[4] == 1'b0)
			begin
				JumpI = 0;
				JumpCI = 0;
				JumpCD = 0;
				MemToReg = 0;
				MemRead = 0;
				MemWrite = 0;
				ALUSrc = 0;
				RegWrite = 1;
				ImmSrc = 2'bxx;
				RegDtn = 2'b01;
				RegSrc2 = 1'b1;
				RegSrc1 = 2'b10;
				
				// SUM
				if (func[4:0] == 5'b00000)
					begin
						ALUOp = 3'b000;
					end
				// RES
				if (func[4:0] == 5'b00001)
					begin
						ALUOp = 3'b001;
					end
				// MUL
				if (func[4:0] == 5'b00010)
					begin
						ALUOp = 3'b010;
					end
				// DIV
				if (func[4:0] == 5'b00011)
					begin
						ALUOp = 3'b011;
					end
				// RSD
				if (func[4:0] == 5'b00100)
					begin
						ALUOp = 3'b100;
					end
				// TEST
				if (func[4:0] == 5'b00110)
					begin
						ALUOp = 3'b110;
					end
			end
		
		// Instrucciones de Datos con inmediato:
		if (instruction_type == 2'b10 && func[4] == 1'b1)
			begin
				JumpI = 0;
				JumpCI = 0;
				JumpCD = 0;
				MemToReg = 0;
				MemRead = 0;
				MemWrite = 0;
				ALUSrc = 1;
				RegWrite = 1;
				ImmSrc = 2'b10;
				RegDtn = 2'b01;
				RegSrc2 = 1'bx;
				RegSrc1 = 2'b10;
				
				// SUMI
				if (func[4:0] == 5'b11000)
					begin
						ALUOp = 3'b000;
					end
				// RESI
				if (func[4:0] == 5'b11001)
					begin
						ALUOp = 3'b001;
					end
				// MULI
				if (func[4:0] == 5'b11010)
					begin
						ALUOp = 3'b010;
					end
				// DIVI
				if (func[4:0] == 5'b11011)
					begin
						ALUOp = 3'b011;
					end
				// RSDI
				if (func[4:0] == 5'b11100)
					begin
						ALUOp = 3'b100;
					end
				// CMP
				if (func[4:0] == 5'b11101)
					begin
						ALUOp = 3'b101;
					end

			end
			
		// Instrucciones de Control:
		if (instruction_type == 2'b00)
			begin
				MemToReg = 0;
				MemRead = 0;
				MemWrite = 0;
				ALUSrc = 0;
				ALUOp = 3'b001;
				RegWrite = 0;
				ImmSrc = 2'b00;
				RegDtn = 2'bxx;
				RegSrc2 = 1'b0;
				RegSrc1 = 2'b00;
				
				// SI instruction
				if (func[4:3] == 2'b00)
					begin
						JumpI = 1;
						JumpCI = 0;
						JumpCD = 0;
					end
				// SCI instruction	
				if (func[4:3] == 2'b10)
					begin
						JumpI = 0;
						JumpCI = 1;
						JumpCD = 0;
					end
				// SCD instruction
				if (func[4:3] == 2'b11)
					begin
						JumpI = 0;
						JumpCI = 0;
						JumpCD = 1;
					end
					
			end
			
		// Instrucciones de Memoria:
		if (instruction_type == 2'b01)
			begin
				JumpI = 0;
				JumpCI = 0;
				JumpCD = 0;
				ALUSrc = 1;
				ALUOp = 3'b000;
				ImmSrc = 2'b01;
				RegDtn = 2'b00;
				RegSrc2 = 1'bx;
				RegSrc1 = 2'b01;
				
				// GDR instruction
				if (func[4] == 1'b0)
					begin
						MemToReg = 1'bx;
						MemRead = 0;
						MemWrite = 1;
						RegWrite = 0;
					end
				// CRG instruction	
				if (func[4] == 1'b1)
					begin
						MemToReg = 1;
						MemRead = 1;
						MemWrite = 0;
						RegWrite = 1;
					end
					
			end
			
	end
endmodule