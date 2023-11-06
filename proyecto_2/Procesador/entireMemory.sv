
/*
	todo: definir bien los tamanos de las memorias
	Memory with segmentation
	Inputs:
	- clk: the clock
	- we: enables writing on data segment
	- a1: instruction segment address
	- a2: data segment address
	- wd: data to write on data segment
	Outputs:
	- rd1: instruction requested
	- rd2: data requested
*/

module entireMemory #(parameter WIDTH = 24)
  (input logic clk,
	input logic [3:0] we,
	input logic [WIDTH*4-1:0] a, wd, //  [95:0]
	output logic [WIDTH*4-1:WIDTH] rd,    //  [95:0]
	output logic [WIDTH-1:0] ri    //  [95:0]
	); 
		
	logic [WIDTH-1:0] rdTemp;	
		
	// [WIDTH-1:0] = [23:0]
	instMem #(24,64) // Instruction mem
		instMem(a[WIDTH-1:0],ri); 
		
	// [WIDTH*2-1:WIDTH] = [47:24]
	//senFuncMem #(24,1024) // Sen Func Mem
	//	senoFuncMemInst(clk,we,a[WIDTH-1:0],wd[WIDTH-1:0],rd[WIDTH-1:0]);	
	
	
	//assign ri = rdTemp;
	// [WIDTH*2-1:WIDTH] = [47:24]
	//senFuncMem #(24,1024) // Sen Func Mem
	//	senoFuncMem(clk,we,a[WIDTH*2-1:WIDTH],wd[WIDTH*2-1:WIDTH],rd[WIDTH*2-1:WIDTH]);
		
	// [WIDTH*3-1:WIDTH*2] = [71:48]
	dInMem #(24,90000) // In data
		dataInMem(clk,we,a[WIDTH*3-1:WIDTH*2],wd[WIDTH*3-1:WIDTH*2],rd[WIDTH*3-1:WIDTH*2]);

	// [WIDTH*4-1:WIDTH*3] = [95:72]
	dOutMem #(24,90000) //Out data
		dataOutMem(clk,we,a[WIDTH*4-1:WIDTH*3],wd[WIDTH*4-1:WIDTH*3],rd[WIDTH*4-1:WIDTH*3]);		
	//	
	
endmodule