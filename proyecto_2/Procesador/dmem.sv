module dmem#(parameter WIDTH = 24, parameter AMOUNT = 90000) 
			(
			input logic clk,
			input logic [3:0] we,
			input logic [WIDTH-1:0] a, wd,
			output logic [WIDTH-1:0] rd
			);
			

		logic [WIDTH-1:0] RAM3 [0:AMOUNT-1]; // [23:0] name [0:89999]-> Datos de entrada
	
		initial
			$readmemb("C://Users//HP//Desktop//TEC//I-2023//Arqui-I//Repo//jpena_computer_architecture_1_2023//proyecto_2//Procesador//mem3.txt",RAM3);					
				
	
		// READ: Salva en rd para enviarlo posteriormente al puerto de lectura.
		assign rd = RAM3[a];  // rd[71:48] = RAM3[a[71:48]]; -> Salva en rd pixel IN del address a	
	
	
		// WRITE
		always_ff @(posedge clk) begin    
			if (we[2]) RAM3[a] <= wd;  // RAM3[a[71:48]]  <= wd[71:48] 
		end
	
	
	
endmodule 

		