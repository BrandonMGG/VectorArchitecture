module tb_regfile_v;

  // Parámetros del test bench
  parameter WIDTH = 24;
  parameter REGNUM = 16;
  parameter VECTOR_WIDTH = 8;
  parameter ADDRESSWIDTH = 4;

  // Señales de entrada
  logic clk, we, isvector, vect_esc;
  logic [ADDRESSWIDTH-1:0] reg_num, reg_num2, wd3;
  logic [2:0] index, index_A;
  logic [WIDTH-1:0] data_in, PC;

  // Señales de salida
  logic [VECTOR_WIDTH-1:0][WIDTH-1:0] data_out, data_out2;
  logic [WIDTH-1:0] data_out_s, data_out_s2;

  // Instancia del módulo regfile_v
  regfile_v #(WIDTH, REGNUM, VECTOR_WIDTH, ADDRESSWIDTH) uut (
    .clk(clk),
    .we(we),
    .reg_num(reg_num),
    .reg_num2(reg_num2),
    .wd3(wd3),
    .index(index),
    .data_in(data_in),
    .data_in_v({data_in, data_in, data_in, data_in, data_in, data_in, data_in, data_in}),
    .PC(PC),
    .isvector(isvector),
    .vect_esc(vect_esc),
    .index_A(index_A),
    .data_out(data_out),
    .data_out2(data_out2),
    .data_out_s(data_out_s),
    .data_out_s2(data_out_s2)
  );

  // Inicialización de las señales de entrada
  initial begin
    clk = 0;
    we = 1;
	 #5;									//---GUarda vector en posicion wd3-----
    isvector = 1'b1;
    vect_esc = 1'b0;
    reg_num = 4'b0000;
    reg_num2 = 4'b0001;
    wd3 = 4'b0010; 					//-----------resgitro a guardar-----------
    index = 3'b001;
    index_A = 3'b010;				
    data_in = 24'h000056;
    PC = 24'hABCDEF;
	 
	 #5;									//---GUarda vector en posicion wd3 con index-----
    isvector = 1'b1;
    vect_esc = 1'b1;
    reg_num = 4'b0000;
    reg_num2 = 4'b0001;
    wd3 = 4'b0011; 					//-----------resgitro a guardar-----------
    index = 3'b001;
    index_A = 3'b010; 				//-----------index a guardar-----------				
    data_in = 24'h000001;
    PC = 24'hABCDEF;
	 
	 
	 
    #5;									//----Lectura valor en regutro wd3 y index_A 
    we = 0;
	 isvector = 1'b1;
    vect_esc = 1'b1;
    reg_num = 4'b0010; 				//-----------resgitro a leer-----------
    reg_num2 = 4'b0001; 			//-----------resgitro a leer-----------
    wd3 = 4'b0011;
    index = 3'b011;					//-----------indice para leer-----------
    index_A = 3'b010;				
    data_in = 24'h000001;
    PC = 24'hABCDEF;
	 
	 #5;									//----Guarda valor en regutro wd3 
    isvector = 1'b1;
    vect_esc = 1'b1;
    reg_num = 4'b0011;
    reg_num2 = 4'b0001;
    wd3 = 4'b0010; 					//-----------resgitro a guardar-----------
    index = 3'b010;
    index_A = 3'b010;				//-----------indice para guardar-----------
    data_in = 24'h000056;
    PC = 24'hABCDEF;

    #100 $stop;
  end

  // Generación de reloj
  always begin
    #1 clk = ~clk;
  end

endmodule
