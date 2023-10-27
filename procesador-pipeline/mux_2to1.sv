module mux_2to1 #(parameter N = 32) (input logic [N-1:0] A, B,
													input logic sel,
													output logic [N-1:0] C);

	always_comb
		case(sel)
		
			// 27-bit unsigned immediate
			1'b0: C = A;
			
			// 17-bit unsigned immediate
			1'b1: C = B;
			
			default: C = A; // undefined
			
		endcase
	
endmodule