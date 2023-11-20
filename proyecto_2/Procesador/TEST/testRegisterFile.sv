module testRegisterFile();
	
	logic clk, writeEnable;
	logic [3:0] pointToAddress1, pointToAddress2, pointToAddressToWrite;
	logic [15:0] writeData3, PC;
	logic [15:0] readData1, readData2;

	
	regfile registerFile(clk, writeEnable, 
								pointToAddress1, pointToAddress2, pointToAddressToWrite,
								writeData3, PC,
								readData1, readData2);
						
	//Creacion de un reloj
	always begin
		clk = 0; #5; clk=~clk; #5;
	end
	
	
	initial begin	
		#5;
	 
		// Ejemplo 1: MOV R3, #9 
		// Escritura (secuencial)
		pointToAddressToWrite = 4'd3; writeData3 = 16'd9; writeEnable = 1; #6; writeEnable = 0; #4;
		
		// Ejemplo 2: MOV R6, #1 
		pointToAddressToWrite = 4'd6; writeData3 = 16'd5; writeEnable = 1; #6; writeEnable = 0; #4;
		
		// Ejemplo 3: ADD R4, R3, R9
		// Lectura (combinacional)
		pointToAddress1 = 4'd3;
		pointToAddress2 = 4'd6; #10;
		
		// Ejemplo 4: B salto
		pointToAddress1 = 4'd6;  // Suponer un salto de 5 espacios
		PC = 16'd4;              // Suponer PC = 4
		pointToAddress2 = 4'd15; #10; // Apuntar a R15 para obtener la posicion actual del PC
		
	end
																
endmodule
