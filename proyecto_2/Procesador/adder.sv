/*
	Adder
	Inputs
	- a
	- b
	Outputs
	- y = a + b
*/
module adder #(parameter WIDTH = 24)
	(input logic [WIDTH-1:0] a, b,
	output logic [WIDTH-1:0] y);
	assign y = a + b;
endmodule