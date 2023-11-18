
module topMemory_v #(parameter WIDTH = 24, parameter DEPTH = 10000,parameter PIXEL = 8,parameter VECTOR_WIDTH = 8)
			(
			input logic startIO,
			input logic clk,
			input logic we,
			input logic [WIDTH-1:0] address,
			input logic [VECTOR_WIDTH-1:0][WIDTH-1:0] wd,
			output logic [WIDTH-1:0] rd
			);
			

		logic [WIDTH-1:0] RAM1 [0:DEPTH-1]; // [23:0] name [0:89999]-> Datos de entrada
		logic  [WIDTH-1:0] addr,addr1,addr2,addr3,addr4,addr5,addr6,addr7, address_in;
		
		
		always@(startIO) 
			// "C:/Users/HP/Desktop/TEC/I-2023/Arqui-I/Repo/jpena_computer_architecture_1_2023/proyecto_2/Procesador/mem4.txt"
			$writememh("/home/guillen/Documents/TEC/Arqui 2/TEST/dataOut.txt",RAM1);					
				
	
		// WRITE
		always_ff @(posedge clk)
		  
        begin
            if (we) 
                begin
						address_in <= address-'d0;
						addr <= address_in -'d24;
						addr1 <= address_in -'d23;
						addr2 <= address_in -'d22;
						addr3 <= address_in -'d21;
						addr4 <= address_in -'d20;
						addr5 <= address_in -'d19;
						addr6 <= address_in -'d18;
						addr7 <= address_in -'d17;
					  if (address_in >= 'd24 && address_in < 'd10024)
							begin
								RAM1[addr] <= {wd[7]};
								RAM1[addr1] <= {wd[6]};
								RAM1[addr2] <= {wd[5]};
								RAM1[addr3] <= {wd[4]};
								RAM1[addr4] <= {wd[3]};
								RAM1[addr5] <= {wd[2]};
								RAM1[addr6] <= {wd[1]};
								RAM1[addr7] <= {wd[0]};
								
							end
							//address_in<=0;

                end
        end	
	
		assign rd = RAM1[addr3];
	
endmodule 
				
					
