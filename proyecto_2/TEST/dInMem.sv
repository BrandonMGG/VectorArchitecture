module dInMem #(parameter WIDTH = 24, parameter AMOUNT = 24,parameter PIXEL = 8) 
(
  input logic [WIDTH-1:0] a,
  output logic [WIDTH-1:0] rd
);

  logic  [WIDTH-1:0] RAM3 [0:AMOUNT-1];

  initial begin
    $readmemh("/home/guillen/Documents/TEC/Arqui 2/TEST/colors-mem.txt", RAM3);
  end

  assign rd = {RAM3[a]}; 
endmodule
