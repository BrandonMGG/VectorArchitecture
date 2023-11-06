module controlunit #(parameter OPCODEWIDTH = 4)
					(output logic  
					writeEnableDD,
					writeDataEnableMD,
					resultSelectorWBD,
					data2SelectorED,
					outFlag,
					output logic [2:0] aluControlED,
					input logic [OPCODEWIDTH-1:0] opcodeD
					);
					
	always@(opcodeD) begin 
		
		case(opcodeD)
			4'b0000: begin 
				writeEnableDD = 0;
				data2SelectorED = 0;
				aluControlED = 3'b000;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b0001: begin 
				writeEnableDD = 0;
			   data2SelectorED =  1'bx;;
				aluControlED = 3'b110;
				writeDataEnableMD = 1;
				resultSelectorWBD =  0;;
				outFlag = 0;
			end
			4'b0010: begin 
				writeEnableDD = 1;
				data2SelectorED = 1;
				aluControlED = 3'b111;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b0011: begin 
				writeEnableDD = 1;
				data2SelectorED =  1'bx;;
				aluControlED = 3'b110;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b0100: begin 
				writeEnableDD = 0;
				data2SelectorED =  1'bx;;
				aluControlED = 3'b110;
				writeDataEnableMD = 0;
				resultSelectorWBD =  0;
				outFlag = 1;
			end
			4'b0101: begin 
				writeEnableDD = 1;
				data2SelectorED = 0;
				aluControlED = 3'b000;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b0110: begin 
				writeEnableDD = 1;
				data2SelectorED = 0;
				aluControlED = 3'b001;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b0111: begin 
				writeEnableDD = 1;
				data2SelectorED = 1'bx;
				aluControlED = 3'b110;
				writeDataEnableMD = 0;
				resultSelectorWBD = 1;
				outFlag = 0;
			end
			4'b1000: begin 
				writeEnableDD = 1;
				data2SelectorED = 0;
				aluControlED = 3'b010;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b1001: begin 
				writeEnableDD = 1;
				data2SelectorED = 0;
				aluControlED = 3'b011;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b1010: begin 
				writeEnableDD = 0;
				data2SelectorED = 0;
				aluControlED = 3'b001;
				writeDataEnableMD = 0;
				resultSelectorWBD =  0;
				outFlag = 0;
			end
			4'b1011: begin 
				writeEnableDD = 0;
				data2SelectorED = 1;
				aluControlED = 3'b111;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;
			end
			4'b1100: begin 
				writeEnableDD = 0;
				data2SelectorED = 1'bx;
				aluControlED = 3'b110;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;		
			end
			4'b1101: begin 
				writeEnableDD = 0;
				data2SelectorED = 1;
				aluControlED = 3'b111;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;			
			end
			4'b1110: begin 
				writeEnableDD = 1;
				data2SelectorED = 0;
				aluControlED = 3'b100;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;					
			end
			4'b1111: begin 
				writeEnableDD = 0;
				data2SelectorED = 1;
				aluControlED = 3'b111;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;			
			end
			default begin
				writeEnableDD = 0;
				data2SelectorED = 0;
				aluControlED = 3'b000;
				writeDataEnableMD = 0;
				resultSelectorWBD = 0;
				outFlag = 0;			
			end
		endcase
		
	
	end
	
	

endmodule
	