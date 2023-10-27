module sign_extend(input logic [27:0] num_in,
							input logic [1:0] imm_src,
							output logic [31:0] num_out);
							
	always_comb
		//Concatena el valor num_in consigomismo para dar un valor de 32 bits
		case(imm_src)
		
			// 27-bit unsigned immediate
			2'b00: num_out = { {12{num_in[19]}}, num_in[19:0]};
			
			// 17-bit unsigned immediate
			2'b01: num_out = { {14{num_in[17]}}, num_in[17:0]};
			
			// 24-bit two's complement shifted branch
			2'b10: num_out = { {15{num_in[16]}}, num_in[16:0]};
			
			default: num_out = 32'bx; // undefined
		endcase
	
endmodule