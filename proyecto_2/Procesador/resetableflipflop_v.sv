/**
	Resetable Flip Flop module 
	Inputs:
	- d: input to save
   - clock: the clock
	- WIDTH: size of the value stored
	- reset: resets the stored value to 0
	Outputs:
 	- q: current saved value
**/
module resetableflipflop_v #(parameter WIDTH = 24,parameter VECTOR_WIDTH = 8)
	(
		input logic clk, reset, enable,
		input logic [VECTOR_WIDTH-1:0][WIDTH-1:0] d,
		output logic [VECTOR_WIDTH-1:0][WIDTH-1:0] q
	);
	
	logic [WIDTH-1:0] out;
	
	always_ff @(posedge clk) begin
		if (reset) begin
							out[0] <= 0;
							out[1] <= 0;
							out[2] <= 0;
							out[3] <= 0;
							out[4] <= 0;
							out[5] <= 0;
							out[6] <= 0;
							out[7] <= 0;
					  end
		else if(enable) begin
							  out[0] <= d[0];
							  out[1] <= d[1];
							  out[2] <= d[2];
							  out[3] <= d[3];
							  out[4] <= d[4];
							  out[5] <= d[5];
							  out[6] <= d[6];
							  out[7] <= d[7];
							  
							  
							  end
	end
	assign q = {out[0],out[1] ,out[2] ,out[3] ,out[4] ,out[5] ,out[6],out[7]   };
endmodule