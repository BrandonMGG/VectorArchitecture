
/*
	To Do: definir bien los tamanos de las memorias
	Memory with segmentation
	Inputs:
	- clk: the clock
	- we: enables writing on data segment
	- a1: instruction segment address
	- a2: //Read data. Se usa solo el a2 que es quien contiene la direccion de mem de los datos a read/write.
	- wd: data to write on data segment
	Outputs:
	- rd1: instruction requested
	- rd2: data requested
*/

/*
Modificar la dimension del puerto wd a [7:0] en lugar de [23:0]
Se debe de modificar en:
topMemory
dInMem
dOutMem


En el modulo de CPU se debe de cambiar el tamano de MemoryDataToWrite a [7:0] y reg2ContentM a [7:0]

Ademas se debe de cambiar la dimension de la memoria

*/

module topMemory #(parameter WIDTH = 24, parameter INSTRUCTIONWIDTH = 24,parameter PIXEL = 24)
  (input logic clk, we, startIO,        		// 1bit
	input logic [WIDTH-1:0]  a2, wd,  		   // [23:0]
	output logic [WIDTH-1:0] rd2);				// [23:0]
	
	// Mantiene valor del input startIO y lo extiende
	logic [WIDTH-1:0] startIOExtended;         // 23:0
	logic [WIDTH-1:0] offset_out_address, dataInAddress, rd_in, rd_out;
	
	assign startIOExtended[WIDTH-1:1] 	= 24'b0; // 23:1
	assign startIOExtended[0] 				= startIO;		 // [0]
	
	dataInMem #(PIXEL,24) dInMem(a2,rd_in);
	
	dOutMem #(24,10000,PIXEL) //Out data
		//dataOutMem(startIO, clk,we,a2-24'd90302,wd[PIXEL-1:0],rd_out);	
		dataOutMem(startIO, clk,we, a2,wd,rd_out);	
	
	// Se usa solo el a2(address) que es quien contiene la direccion de mem de los datos a read/write.
	always_comb 
		begin
			//>>>>>>>>>>>>>>>>>>>>>>> Read data
		
			// -------------- Switch de inicio. Se necesita al inicio del programa, donde, si rd2 = 1 se inicia y si no se espera a que este tenga tal valor.
			if (a2 == 'd20) rd2 = startIOExtended; 
			
			else if (a2 < 'd24) rd2 = rd_in; // 0<=a2<24
						 
					 
			else if ((a2 < 'd10024) && ('d24 <= a2)) rd2  = rd_out; 			// 24<=a2<10000    | Pixel salida.
				
				
			else rd2 = 24'b0;
				
				
		end
	
endmodule
