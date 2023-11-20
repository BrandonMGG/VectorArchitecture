module regfile_v #(
  parameter WIDTH = 24,
  parameter REGNUM = 16,
  parameter VECTOR_WIDTH = 8,
  parameter ADDRESSWIDTH = 4
)
(
  input logic clk,
  input logic we,
  input logic [ADDRESSWIDTH-1:0] reg_num, reg_num2, wd3,
  input logic [2:0] index,
  input logic [WIDTH-1:0] data_in,
  input logic [VECTOR_WIDTH-1:0][WIDTH-1:0]data_in_v,
  input logic [WIDTH-1:0]PC,
  input logic  isvector,vect_esc,
  input logic [2:0] index_A,
  //output logic [3:0] reg_out,
  output logic [VECTOR_WIDTH-1:0][WIDTH-1:0] data_out, data_out2,
  output logic [WIDTH-1:0] data_out_s, data_out_s2
);

  logic [VECTOR_WIDTH-1:0][WIDTH-1:0] rf [REGNUM-1:0];

  always_ff @(posedge clk)
    if (we) begin
      case ({isvector,vect_esc})
		  2'b10: // Scalar write to vector register
          rf[wd3] <= data_in_v;
        2'b11: // Neither vector nor scalar
          rf[wd3][index_A] <= data_in;
        
      endcase
		end
	  always_comb begin
		 // reg_out = reg_num;
		 data_out = {rf[reg_num][0], rf[reg_num][1], rf[reg_num][2], rf[reg_num][3], rf[reg_num][4],
						 rf[reg_num][5], rf[reg_num][6], rf[reg_num][7]};
		 
		 data_out2 = {rf[reg_num2][0], rf[reg_num2][1], rf[reg_num2][2], rf[reg_num2][3], rf[reg_num2][4],
						  rf[reg_num2][5], rf[reg_num2][6], rf[reg_num2][7]};
		 
		 case(reg_num)
			  4'b1111: data_out_s = PC;
			  default: data_out_s = rf[reg_num][index];
		 endcase

		 case(reg_num2)
			  4'b1111: data_out_s2 = PC;
			  default: data_out_s2 = rf[reg_num2][index];
		 endcase
	end

endmodule