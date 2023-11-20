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
module resetableflipflop #(parameter WIDTH = 24)
	(
		input logic clk, reset, enable,
		input logic [WIDTH-1:0] d,
		output logic [WIDTH-1:0] q
	);
	
	logic [WIDTH-1:0] out;
	
	always_ff @(posedge clk) begin
		if (reset) out <= 0;
		else if(enable) out <= d;
	end
	assign q = out;
endmodule