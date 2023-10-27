module alu( input [31:0] A, B,
				input [2:0] sel,
				output [31:0] C,
				output flagZ);
	
	reg [31:0] alu_out_temp;
	
	always @(*)
	//Casos de la ALU en sus diferentes operaciones
		case (sel)
		
			// caso de la suma
			3'b000: alu_out_temp = A + B; 
			
			// caso de la resta
			3'b001: alu_out_temp = A - B;
			
			// caso de la multiplicación
			3'b010: alu_out_temp = A * B;
			
			// caso de la división
			3'b011: alu_out_temp = A / B;
			
			// caso del residuo
			3'b100: alu_out_temp = A % B;
			
			// caso del CMP
			3'b101: alu_out_temp = (A >= 0 && A < B) ? 1 : 0;
			
			// caso del test
			3'b110: alu_out_temp = ((A - 1) / 37) % 2;
			
			default: alu_out_temp = A + B; 
		
		endcase 
		
	// resultado de la alu
	assign C = alu_out_temp;
	
	// banderas
	assign flagZ = (alu_out_temp == 31'd0);	// bandera de cero (Z)
	
endmodule 