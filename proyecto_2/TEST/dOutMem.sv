module dOutMem #(parameter WIDTH = 24, parameter DEPTH = 10000,parameter PIXEL = 8)
			(
			input logic startIO,
			input logic clk,
			input logic we,
			input logic [WIDTH-1:0] address,
			input logic [WIDTH-1:0] wd,
			output logic [WIDTH-1:0] rd
			);
			

		logic [WIDTH-1:0] RAM1 [0:DEPTH-1]; // [23:0] name [0:89999]-> Datos de entrada
		logic  [WIDTH-1:0] addr;
		
		always@(startIO) 
			// "C:/Users/HP/Desktop/TEC/I-2023/Arqui-I/Repo/jpena_computer_architecture_1_2023/proyecto_2/Procesador/mem4.txt"
			$writememh("/home/guillen/Documents/TEC/Arqui 2/TEST/dataOut.txt",RAM1);					
				
	
		// WRITE
		always_ff @(posedge clk)
        begin
            if (we) 
                begin
						addr <= address -'d24;
					  if (address >= 'd24 && address < 'd10024)
							begin
							RAM1[addr] <= wd;
							end

                end
        end	
	
		assign rd = RAM1[addr];
	
endmodule 
				
					
