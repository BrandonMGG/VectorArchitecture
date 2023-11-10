module instMem #(parameter WIDTH = 24, parameter AMOUNT = 256) 
			(
			input logic [WIDTH-1:0] a,
			output logic [WIDTH-1:0] rd
			);
			

		logic [WIDTH-1:0] ROM1 [0:AMOUNT-1]; // [23:0] name [0:89999]-> Datos de entrada
	
		initial
		/*
		"C://Users//HP//Desktop//TEC//I-2023//Arqui-I//Repo//jpena_computer_architecture_1_2023//proyecto_2//Procesador//mem1.txt"
		*/
			$readmemb("C://Users//HP//Desktop//TEC//I-2023//Arqui-I//Repo//jpena_computer_architecture_1_2023//proyecto_2//Procesador//instr-algo.txt",ROM1);					
				
	
		// READ: Salva en rd para enviarlo posteriormente al puerto de lectura.
		always_comb rd = ROM1[a];  // rd[71:48] = RAM3[a[71:48]]; -> Salva en rd pixel IN del address a	
	

	
	
endmodule 