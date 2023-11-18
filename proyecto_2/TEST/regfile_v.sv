module regfile_simple #(
  parameter WIDTH = 24,
  parameter REGNUM = 16,
  parameter VECTOR_WIDTH = 8
)
(
  input logic clk,
  input logic we,
  input logic [3:0] reg_num,
  input logic [2:0] index,
  input logic [WIDTH-1:0] data_in,
  output logic [3:0] reg_out,
  output logic [VECTOR_WIDTH-1:0][WIDTH-1:0] data_out,
  output logic [WIDTH-1:0] data_out_s
);

  logic [WIDTH-1:0] rf [REGNUM-1:0][VECTOR_WIDTH-1:0];

  always_ff @(posedge clk)
    if (we) rf[reg_num][index] <= data_in;

  always_comb begin
    reg_out = reg_num;
    data_out = {rf[reg_num][0],rf[reg_num][1],rf[reg_num][2],rf[reg_num][3],rf[reg_num][4],
	 rf[reg_num][5],rf[reg_num][6],rf[reg_num][7]};
	 data_out_s= rf[reg_num][index];
  end

endmodule
