module mux_4to1 #(parameter N = 4) (input logic [N-1:0] A, B, C, D,
													input logic [1:0] sel,
													output logic [N-1:0] E);

	always_comb
		case(sel)
		
			// 27-bit unsigned immediate
			2'b00: E = A;
			
			// 01 case:
			2'b01: E = B;
			
			// 01 case:
			2'b10: E = C;
			
			// 11 case:
			2'b11: E = D;
			
			//default: E = 32'bx; // undefined
			
		endcase
	
endmodule