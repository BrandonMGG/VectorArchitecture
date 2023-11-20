module dataInMem #(parameter WIDTH = 24, parameter DEPTH = 24) 
			(
			input logic [WIDTH-1:0] address,
			output logic [WIDTH-1:0] rd
			);
			

		logic [WIDTH-1:0] ROM2 [0:DEPTH-1];
	
		initial
		//"C://Users//HP//Desktop//TEC//II-2023//Arquitectura de computadores II//VectorArchitecture//proyecto_2//Procesador//"
			$readmemh("C://Users//HP//Desktop//TEC//II-2023//Arquitectura de computadores II//VectorArchitecture//proyecto_2//Procesador//colors-mem.txt",ROM2);					
				
	
		// READ
		assign rd = ROM2[address];  //Salva en rd pixel IN del address a	
	
	
	
endmodule 
	