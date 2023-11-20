module ALU #(parameter WIDTH = 24)( 
    input [WIDTH-1:0] A,
	 input [WIDTH-1:0] B,
	 input [2:0] sel,
    output logic [WIDTH-1:0] Out,
	 output logic N, // Negative
	 output logic Z, // Zero
	 output logic V, // Overflow
	 output logic C  //Carry
);


	//=============SUMADOR and SUBSTRACTOR =============

	logic [WIDTH-1:0] OutSumador;
	logic CSumador,VSumador;

	Adder_Substractor #(.WIDTH( WIDTH )) Sumador(A,B,OutSumador,sel[0],CSumador,VSumador); // The sel is need to select between add abd sub
	
	

	//=============MULT=============
	
	logic [WIDTH-1:0] OutMULT;
	logic CMULT,VMULT;

	multiplicador #( WIDTH ) MULT(A,B,OutMULT,VMULT,CMULT);

	
	//=============DIV=============
	
	logic [WIDTH-1:0] OutDIV;
	logic CDIV,VDIV;

	divisor #( WIDTH ) DIV(A,B,OutDIV,VDIV,CDIV);	
	
	
	//=============MOD=============
	
	logic [WIDTH-1:0] OutMOD;
	logic CMOD,VMOD;

	modulo #( WIDTH ) MOD(A,B,OutMOD,VMOD,CMOD);		
	

	/*
	//=============AND=============
	
	logic [WIDTH-1:0] OutAND;
	logic CAND,VAND;

	and_modulo #( WIDTH ) AND(A,B,OutAND,VAND,CAND);
	
	//=============OR=============
	
	logic [WIDTH-1:0] OutOR;
	logic COR,VOR;

	or_modulo #( WIDTH ) OR(A,B,OutOR,VOR,COR);
	
	//=============XOR=============
	
	logic [WIDTH-1:0] OutXOR;
	logic CXOR,VXOR;

	xor_modulo #( WIDTH ) XOR(A,B,OutXOR,VXOR,CXOR);
	*/
	
	//=============SHIFTL=============
	
	logic [WIDTH-1:0] OutShiftL;
	logic CShiftL,VShiftL;

	shiftL_modulo #( WIDTH ) ShiftL(A, B, OutShiftL,VShiftL,CShiftL);
	
	
	

	always_comb begin  
	
      case (sel)  
         3'b000,			//000 ADD
			3'b001 : begin //001 SUB
				Out = OutSumador;
				C <= CSumador;
				V <= VSumador;
				
			end
			3'b010 : begin   // MULT
				Out = OutMULT;
				C <= CMULT;
				V <= VMULT;
				
			end
			3'b011 :begin
				Out = OutDIV; // Div
				C <= CDIV;
				V <= VDIV;
				
			end
			3'b100 : begin  // MOD
				Out = OutMOD;
				C <= CMOD;
				V <= VMOD;
				
			end
			3'b101 : begin 
				Out = OutShiftL;
				C <= CShiftL;
				V <= VShiftL;
				
			end
			3'b110 : begin // GUESS: bypass the ALU and put the A value in the output
				Out = A;
				C <= 0;
				V <= 0;

			end
			3'b111 : begin // GUESS:  bypass the ALU and put the B value in the output
				Out = B;
				C <= 0;
				V <= 0;

			end
			default : begin
				Out = A;
				C <= 0;
				V <= 0;
				
			end
      endcase 
	
		N <= Out[WIDTH-1];
		Z <= ~|Out;
		
   end
	
endmodule