module mux4a2 #(parameter WIDTH = 24)
	(input logic [WIDTH-1:0] d0, d1, d2, d3,
	input logic [1:0] s,
	output logic [WIDTH-1:0] y1,y2);
	
	
	always_comb begin
		case (s)
			2'b00: begin 
						y1 = d0;
						y2 = d1;
					 end
			2'b01: begin 
						y1 = d0;
						y2 = d1;
					 end
			2'b10: begin 
						y1 = d2;
						y2 = d3;
					 end
			2'b11: begin 
						y1 = d2;
						y2 = d0;
					 end
		endcase
	end
	
endmodule