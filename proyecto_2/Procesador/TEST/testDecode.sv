module tb_Decode;

  // Parámetros del test bench
  parameter WIDTH = 24;
  parameter REGNUM = 8;
  parameter VECTOR_WIDTH = 8;
  parameter ADDRESSWIDTH = 4;
  parameter OPCODEWIDTH = 4;
  parameter INSTRUCTIONWIDTH = 24;

  // Señales de entrada
  logic clock, reset, writeEnable, isvector_A, vect_esc_A;
  logic [ADDRESSWIDTH-1:0] writeAddress;
  logic [WIDTH-1:0] dataToSave, PC;
  logic [INSTRUCTIONWIDTH-1:0] instruction;
  logic [VECTOR_WIDTH-1:0][WIDTH-1:0] dataToSave_v;
  logic [2:0] index_A;

  // Señales de salida
  logic [WIDTH-1:0] reg1Content, reg2Content, inmediate;
  logic [ADDRESSWIDTH-1:0] regDestinationAddress, reg1Address, reg2Address;
  logic [OPCODEWIDTH-1:0] opcode;
  logic [VECTOR_WIDTH-1:0][WIDTH-1:0] data_out, data_out2;
  logic isvector, vect_esc;
  logic [2:0] index1;

  // Instancia del módulo Decode
  Decode #(WIDTH, REGNUM, ADDRESSWIDTH, OPCODEWIDTH, INSTRUCTIONWIDTH, VECTOR_WIDTH) uut (
    .writeAddress(writeAddress),
    .dataToSave(dataToSave),
    .PC(PC),
    .instruction(instruction),
    .clock(clock),
    .reset(reset),
    .writeEnable(writeEnable),
    .dataToSave_v(dataToSave_v),
    .isvector_A(isvector_A),
    .vect_esc_A(vect_esc_A),
    .index_A(index_A),
    .reg1Content(reg1Content),
    .reg2Content(reg2Content),
    .inmediate(inmediate),
    .regDestinationAddress(regDestinationAddress),
    .reg1Address(reg1Address),
    .reg2Address(reg2Address),
    .opcode(opcode),
    .data_out(data_out),
    .data_out2(data_out2),
    .isvector(isvector),
    .vect_esc(vect_esc),
    .index1(index1)
  );

  // Inicialización de las señales de entrada
  initial begin
    clock = 0;
    reset = 0;
    writeEnable = 0;
    isvector_A = 0;
    vect_esc_A = 0;
    writeAddress = 4'b0000;
    dataToSave = 24'h000000;
    PC = 24'h000000;
    instruction = 24'b000000000000000000000000;
    dataToSave_v = '{24'h000000, 24'h000000, 24'h000000, 24'h000000, 24'h000000, 24'h000000, 24'h000000, 24'h000000};
    index_A = 3'b000;

    // Puedes continuar con las asignaciones y estímulos según tus necesidades
	  #10;
    // Ejemplo 1: Guardar valores escalares
	  // 24'b 00000000-0001-0010-000-0-0-000
		//     relleno  reg1-reg2-_-isv-vs-ind
     instruction = 24'b001100010010010000000000;
     writeEnable = 1;
     writeAddress = 4'd3;
     dataToSave = 24'd9;
	  isvector_A = 0;
     vect_esc_A = 0;

     #10;
    
	  // 24'b 00000000-0001-0010-000-0-0-000
		//     relleno  reg1-reg2-_-isv-vs-ind
     instruction = 24'b001100010010010000000000;
     writeEnable = 1;
     writeAddress = 4'd2;
     dataToSave = 24'd5;
	  isvector_A = 0;
     vect_esc_A = 0;
	  //------------------------------------------------------------------
	  #10;
     // Ejemplo 2: Leer valores escalares
	  // 24'b 00000000-0001-0010-000-0-0-000
		//     relleno  reg1-reg2-_-isv-vs-ind
     instruction = 24'b000000000011001000000000;
     writeEnable = 0;
	  #10;
	  
    // Ejemplo 3: Guardar valores vectorial
	  // 24'b 00000000-0001-0010-000-0-0-000
		//     relleno  reg1-reg2-_-isv-vs-ind
     instruction = 24'b000000000001001000010000;
     writeEnable = 1;
     writeAddress = 4'd4;
     dataToSave_v = '{24'h000002, 24'h000001, 24'h000006, 24'h000004, 24'h000008, 24'h000004, 24'h000003, 24'h000002};
	  isvector_A = 1;
     vect_esc_A = 0;

     #10;
  
    // Ejemplo 3: Leer valores vectorial
	  // 24'b 00000000-0001-0010-000-0-0-000
		//     relleno  reg1-reg2-_-isv-vs-ind
     instruction = 24'b000000000100000000010000;
     writeEnable = 0;
     writeAddress = 4'd4;
     dataToSave_v = '{24'h000002, 24'h000001, 24'h000006, 24'h000004, 24'h000008, 24'h000004, 24'h000003, 24'h000002};
	  isvector_A = 1;
     vect_esc_A = 0;
	  #10;
  
    // Ejemplo 4: Guardar valores vectorial con indice
	  // 24'b 00000000-0001-0010-000-0-0-000
		//     relleno  reg1-reg2-_-isv-vs-ind
     instruction = 24'b000000000100000000011000;
     writeEnable = 1;
     writeAddress = 4'd3;
     dataToSave = 24'd10;
	  isvector_A = 1;
     vect_esc_A = 1;
	  index_A = 3'b010;
	  
	  
	  #10;
  
    // Ejemplo 4: Guardar valores vectorial con indice
	  // 24'b 00000000-0001-0010-000-0-0-000
		//     relleno  reg1-reg2-_-isv-vs-ind
     instruction = 24'b000000000011000000011010;
     writeEnable = 0;
     writeAddress = 4'd3;
     dataToSave = 24'd10;
	  isvector_A = 1;
     vect_esc_A = 1;
	  index_A = 3'b010;
	  
     #10;
    // Puedes agregar más estímulos según sea necesario

    #100 $stop;
  end

  // Generación de reloj
  always begin
    #5 clock = ~clock;
  end

endmodule
