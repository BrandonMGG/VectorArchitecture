/*
	hazardsUnit
	Inputs:
	-
	Outputs:
	-
*/

module hazardsUnitsv #(parameter WIDTH = 24, parameter ADDRESSWIDTH = 4)
	(input logic writeEnableDWB, writeEnableDM, resultSelectorWBE, takeBranchE,
	input logic [ADDRESSWIDTH-1:0] writeAddressM, writeAddressW, writeAddressE,
	reg1ReadAddressE, reg2ReadAddressE, reg1ReadAddressD, reg2ReadAddressD,
	output logic [1:0] data1ForwardSelectorE, data2ForwardSelectorE,
	output logic stallF, stallD, flushE, flushD);
	
	logic LDRstall;
	logic Match_12D_E;
	
	always_comb begin
		// Forwarding
		data1ForwardSelectorE = 2'b00;
		data2ForwardSelectorE = 2'b00;
		if(writeEnableDWB) begin 
			if (reg1ReadAddressE == writeAddressW) begin
				data1ForwardSelectorE = 2'b01;
			end
			if (reg2ReadAddressE == writeAddressW ) begin
				data2ForwardSelectorE = 2'b01;
			end
		end 
		
		if(writeEnableDM) begin 
			if(reg1ReadAddressE == writeAddressM) begin
			data1ForwardSelectorE = 2'b10;
			end 
			if (reg2ReadAddressE == writeAddressM ) begin
			data2ForwardSelectorE = 2'b10;
			end
		end 
		
		// Stalls on Load and Branching
		
		Match_12D_E = (reg1ReadAddressD == writeAddressE) || (reg2ReadAddressD == writeAddressE);
		LDRstall = Match_12D_E && resultSelectorWBE;
		
		stallD = LDRstall;
		stallF = LDRstall;
		flushE = LDRstall || takeBranchE;
		flushD = takeBranchE;
	end
	
endmodule