module testFetch
				#(parameter WIDTH = 16, parameter REGNUM = 16, 
				parameter ADDRESSWIDTH = 4, parameter OPCODEWIDTH = 4,
				parameter INSTRUCTIONWIDTH = 24)();

	logic clk, reset, takeBranchE;
	logic [WIDTH-1:0] NewPCF;
	logic stallF, stallD, flushD;
	logic [WIDTH-1:0] PCF, PCD, PCPlus1;
	logic [INSTRUCTIONWIDTH-1:0] InstructionF, InstructionD;
	
	logic [WIDTH-1:0] PCDExpected;
	logic [INSTRUCTIONWIDTH-1:0] InstructionDExpected;
	
	CPU_Fetch testFetch(clk, reset, 
					takeBranchE,
					NewPCF,
					stallF, stallD, flushD,
					PCF, PCD, PCPlus1,
					InstructionF, InstructionD
					);
								
								
	//Creacion de un reloj
	initial begin
		clk = 0; #5; clk=~clk; #5;
		clk = 0; #5; clk=~clk; #5;
		clk = 0; #5; clk=~clk; #5;
		clk = 0; #5; clk=~clk; #5;
		clk = 0; #5; clk=~clk; #5;
		clk = 0; #5; clk=~clk; #5;
		clk = 0; #5; clk=~clk; #5;
	end
	
	initial begin	
		#5; reset <= 1; #1; reset <= 0; 
		
		$display ("============= Fetch =============");
		
		// Ejemplo 1:
		stallF = 0;
		stallD = 0;
		takeBranchE = 0;
		InstructionDExpected = 0;
		PCDExpected = 0;
		#9;
		
		// Ejemplo 2:
		stallF = 1;
		stallD = 0;
		takeBranchE = 0;
		#1;
	   assert (InstructionD == InstructionDExpected && PCD == PCDExpected) 
					$display ($sformatf("exito para InstructionD = %b, PCD = %b", InstructionD, PCD));
		else $error($sformatf("fallo para InstructionD = %b, PCD = %b", InstructionD, PCD));
		InstructionDExpected = 0;
		PCDExpected = 0;
		#9;

		// Ejemplo 3:
		stallF = 0;
		stallD = 0;
		takeBranchE = 1; NewPCF = 16'd3;
		#1;
	   assert (InstructionD == InstructionDExpected && PCD == PCDExpected) 
					$display ($sformatf("exito para InstructionD = %b, PCD = %b", InstructionD, PCD));
		else $error($sformatf("fallo para InstructionD = %b, PCD = %b", InstructionD, PCD));
		InstructionDExpected = 3;
		PCDExpected = 3;
		#9;
		
		// No hace nada
		#1
		assert (InstructionD == InstructionDExpected && PCD == PCDExpected) 
					$display ($sformatf("exito para InstructionD = %b, PCD = %b", InstructionD, PCD));
		else $error($sformatf("fallo para InstructionD = %b, PCD = %b", InstructionD, PCD));
		#9;
		
		// Ejemplo 4:
		flushD = 1;
		InstructionDExpected = 0;
		PCDExpected = 0;
		#10;
		
		#1;
		assert (InstructionD == InstructionDExpected && PCD == PCDExpected) 
					$display ($sformatf("exito para InstructionD = %b, PCD = %b", InstructionD, PCD));
		else $error($sformatf("fallo para InstructionD = %b, PCD = %b", InstructionD, PCD));
		#9;
		
	end
																
endmodule
