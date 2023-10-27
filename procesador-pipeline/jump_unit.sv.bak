module jump_unit(
	input FlagZ,
	input JumpCD,
	input JumpCI,
	input JumpI,
	output PCSource
	);
	
	// xor_gate = FlagZ ^ JumpCD
	
	// and_gate_1 = (FlagZ ^ JumpCD) & JumpCD	
	
	// and_gate_2 = FlagZ & JumpCI	
	
	// or_gate = ((FlagZ ^ JumpCD) & JumpCD) | JumpI | (FlagZ & JumpCI)
	
	assign PCSource = ((FlagZ ^ JumpCD) & JumpCD) | JumpI | (FlagZ & JumpCI);
	
endmodule
