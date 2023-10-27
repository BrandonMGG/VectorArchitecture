module jump_unit(
	input FlagZ,
	input JumpCD,
	input JumpCI,
	input JumpI,
	output PCSource
	);
	
	//Opera el valor de las banderas dando como resultado un PC
	
	assign PCSource = ((FlagZ ^ JumpCD) & JumpCD) | JumpI | (FlagZ & JumpCI);
	
endmodule
