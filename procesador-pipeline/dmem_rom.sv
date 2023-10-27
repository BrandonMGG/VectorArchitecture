module dmem_rom (input logic [31:0] address,
				output logic [31:0] rd);
	
	//logic [31:0] dmem_ROM[0:8099];
	logic [31:0] dmem_ROM[0:90000];
	
	initial
	
		//Lee de memoria
		$readmemh("/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/imageData.txt", dmem_ROM);
		
		
	assign rd = dmem_ROM[address[31:0]];
	
endmodule 