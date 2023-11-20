/*
	Fetch  Module
	Inputs: 
	- NewPC : new pc
   - PCSelector: indicates which pc value to use
	- clock
	- reset
	Outputs:
	- PC: the current PC value
	- PCPlus8: PC + 4?
*/
module Fetch #(parameter WIDTH = 24)
	(input logic [WIDTH-1:0] NewPC,
	 input logic PCSelector, clock, reset, enable,
	 output logic [WIDTH-1:0] PC, PCPlus1
	 );
	
	logic [WIDTH-1:0] TempPC;
	
	resetableflipflop  #(WIDTH) pcflipflop(clock, reset, enable, TempPC ,PC);
	mux2  #(WIDTH) pcmux (PCPlus1, NewPC, PCSelector, TempPC);
	adder  #(WIDTH) pcadder(PC, 24'b1, PCPlus1);
	
endmodule
