module pc_register(
	input clk,
	input clr,
	input load,
	input [31:0] pc_in,
	output [31:0] pc_out
	);
	
	logic [31:0] pc;
	logic [31:0] pc_temp;
	
	always_ff @(posedge clk) begin
	
		pc_temp <= pc;
			
	end
	
	always_ff @(posedge clk, negedge clr) begin
	
		if (clr == 0)
		
			pc <= 0;
			
		else if (load == 1)
		
			pc <= pc_in;
			
		else
		
			pc <= pc;
	
	end
	
	assign pc_out = pc;
	
endmodule
