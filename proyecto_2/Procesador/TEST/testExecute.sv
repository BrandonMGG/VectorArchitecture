`timescale 1 ns / 1 ns
module tb_Execute;

  // Parámetros del test bench
  parameter WIDTH = 24;
  parameter VECTOR_WIDTH = 8;

  // Señales de entrada
  logic [WIDTH-1:0] data1, data2, data3,forwardM, forwardWB;
  logic [2:0] ALUControlE;
  logic ALUSrcE;
  logic [1:0] data1ForwardSelector, data2ForwardSelector;
  logic [VECTOR_WIDTH-1:0] [WIDTH-1:0] A, B;
  logic isvector;

  // Señales de salida
  logic [WIDTH-1:0] data2AfterForward, ALUResultE;
  logic [VECTOR_WIDTH-1:0] [WIDTH-1:0] Out_v;
  logic N, Z, V, C;

  // Instancia del módulo Execute
  Execute #(WIDTH, VECTOR_WIDTH) uut (
    .data1(data1), .data2(data2), .data3(data3),
    .forwardM(forwardM), .forwardWB(forwardWB),
    .ALUControlE(ALUControlE), .ALUSrcE(ALUSrcE),
    .data1ForwardSelector(data1ForwardSelector), .data2ForwardSelector(data2ForwardSelector),
    .A(A), .B(B),
    .isvector(isvector),
    .data2AfterForward(data2AfterForward), .ALUResultE(ALUResultE),
    .Out_v(Out_v),
    .N(N), .Z(Z), .V(V), .C(C)
  );

  // Inicialización de las señales de entrada
  initial begin
    data1 = 24'h1;  // Puedes inicializar estas señales con los valores que desees
    data2 = 24'h2;
    data3 = 24'h3;
    forwardM = 24'h4;
    forwardWB = 24'h5;
    ALUControlE = 3'b000;
    ALUSrcE = 1'b0;
    data1ForwardSelector = 2'b00;
    data2ForwardSelector = 2'b00;
    A = {24'h000001, 24'h000002, 24'h000003, 24'h000004, 24'h000005, 24'h000006, 24'h000007, 24'h000008};
    B = {24'h000001, 24'h000002, 24'h000003, 24'h000004, 24'h000005, 24'h000006, 24'h000007, 24'h000008};
    isvector = 1'b0;

    #5;
	 ALUControlE = 3'b001;
	 #5;
	 ALUControlE = 3'b010;
	 #5;
	 ALUControlE = 3'b011;
	 #5;
	 ALUControlE = 3'b100;
	 #5;
	 ALUControlE = 3'b101;
	 #5;
	 ALUControlE = 3'b110;
	 #5;
	 ALUControlE = 3'b111;
    

    // Finaliza la simulación después de cierto tiempo
    #1000 $stop;
  end

endmodule
