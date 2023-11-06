module iMem #(parameter WIDTH = 24, parameter AMOUNT = 64) 
			(
			input logic clk,
			input logic [3:0] we,
			input logic [WIDTH-1:0] a, wd,
			output logic [WIDTH-1:0] rd
			);
			

		logic [WIDTH-1:0] RAM1 [0:AMOUNT-1]; // [23:0] name [0:89999]-> Datos de entrada
	
		//initial
		//	$readmemb("G://My Drive//TEC//2023 Semestre I//Arquitectura de Computadores I//Proyectos//Proyectoll//DesarrolloProyecto//Proyecto02//mem1.txt",RAM1);					
				
	
		// READ: Salva en rd para enviarlo posteriormente al puerto de lectura.
		assign rd = RAM1[a];  // rd[71:48] = RAM3[a[71:48]]; -> Salva en rd pixel IN del address a	
	
	
		// WRITE
		always_ff @(posedge clk) begin    
			if (we[0]) RAM1[a] <= wd;  // RAM3[a[71:48]]  <= wd[71:48] 
		end	
	
	
endmodule 
	
	