`timescale 1ns/1ps

module tb_ALU_v;

  // Parameters
  parameter WIDTH = 24;
  parameter VECTOR_WIDTH = 8;

  // Signals
  logic [VECTOR_WIDTH-1:0] [WIDTH-1:0] A ;
  logic [VECTOR_WIDTH-1:0] [WIDTH-1:0] B ;
  logic [VECTOR_WIDTH-1:0] [WIDTH-1:0] Out;
  logic N, Z, V, C;
  logic [2:0] sel;

  // Clock generation
  reg clk = 0;
  always #5 clk = ~clk;

  // Instantiate the ALU_v module
  vector_alu #(
    .WIDTH(WIDTH),
    .VECTOR_WIDTH(VECTOR_WIDTH)
  ) uut (
    .A(A), .B(B), .sel(sel),
    .Out(Out), .N(N), .Z(Z), .V(V), .C(C)
  );

  // Test stimulus
  initial begin
    // Initialize inputs
    A = {24'h000001, 24'h000002, 24'h000003, 24'h000004, 24'h000005, 24'h000006, 24'h000007, 24'h000008};
    B = {24'h000001, 24'h000002, 24'h000003, 24'h000004, 24'h000005, 24'h000006, 24'h000007, 24'h000008};
    sel = 3'b000; // ADD operation initially

    // Apply stimulus
    #10 sel = 3'b010; // MULT operation
    #10 sel = 3'b001; // SUB operation
	 #10 sel = 3'b111; // SUB operation
    // Add more test cases as needed...

    // Monitor and display results
    #10;
    $display("A = %p", A);
    $display("B = %p", B);
    $display("Out = %p", Out);
    $display("N = %b, Z = %b, V = %b, C = %b", N, Z, V, C);

    // Stop simulation
    $stop;
  end

endmodule
