module vector_alu #(parameter WIDTH = 24, parameter VECTOR_WIDTH = 8)( 
    input [VECTOR_WIDTH-1:0] [WIDTH-1:0] A ,
	 input [VECTOR_WIDTH-1:0] [WIDTH-1:0]  B ,
	 input [2:0] sel,
    output logic [VECTOR_WIDTH-1:0] [WIDTH-1:0] Out ,
	 output logic N, // Negative
	 output logic Z, // Zero
	 output logic V, // Overflow
	 output logic C  //Carry
);


	//=============SUMADOR and SUBSTRACTOR =============

	logic [VECTOR_WIDTH-1:0] [WIDTH-1:0] OutSumador ;
	logic [VECTOR_WIDTH-1:0] CSumador ,VSumador ;

	//se crea un for con las n iteracciones (todos los elementos vectoriales ) o directamente se establece un numero fijo de operadores
	//tambien se debe crear algun metodo para las banderas 
	Adder_Substractor #(.WIDTH( WIDTH )) Sumador0(A[0],B[0],OutSumador[0],sel[0],CSumador[0],VSumador[0]); // The sel is need to select between add and sub
	Adder_Substractor #(.WIDTH( WIDTH )) Sumador1(A[1],B[1],OutSumador[1],sel[0],CSumador[1],VSumador[1]); // The sel is need to select between add and sub
	Adder_Substractor #(.WIDTH( WIDTH )) Sumador2(A[2],B[2],OutSumador[2],sel[0],CSumador[2],VSumador[2]); // The sel is need to select between add and sub
	Adder_Substractor #(.WIDTH( WIDTH )) Sumador3(A[3],B[3],OutSumador[3],sel[0],CSumador[3],VSumador[3]); // The sel is need to select between add and sub
	Adder_Substractor #(.WIDTH( WIDTH )) Sumador4(A[4],B[4],OutSumador[4],sel[0],CSumador[4],VSumador[4]); // The sel is need to select between add and sub
	Adder_Substractor #(.WIDTH( WIDTH )) Sumador5(A[5],B[5],OutSumador[5],sel[0],CSumador[5],VSumador[5]); // The sel is need to select between add and sub
	Adder_Substractor #(.WIDTH( WIDTH )) Sumador6(A[6],B[6],OutSumador[6],sel[0],CSumador[6],VSumador[6]); // The sel is need to select between add and sub
	Adder_Substractor #(.WIDTH( WIDTH )) Sumador7(A[7],B[7],OutSumador[7],sel[0],CSumador[7],VSumador[7]); // The sel is need to select between add and sub
	

	//=============MULT=============
	
	logic [WIDTH-1:0] OutMULT;
	logic CMULT,VMULT;

	multiplicador #( WIDTH ) MULT(A[0],B[0],OutMULT,VMULT,CMULT);

	
	//=============DIV=============
	
	logic [WIDTH-1:0] OutDIV;
	logic CDIV,VDIV;

	divisor #( WIDTH ) DIV(A[0],B[0],OutDIV,VDIV,CDIV);	
	
	
	//=============MOD=============
	
	logic [WIDTH-1:0] OutMOD;
	logic CMOD,VMOD;

	modulo #( WIDTH ) MOD(A[0],B[0],OutMOD,VMOD,CMOD);		
	

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

	shiftL_modulo #( WIDTH ) ShiftL(A[0], B[0], OutShiftL,VShiftL,CShiftL);
	
	
	

	always_comb begin  
	
      case (sel)  
         3'b000,			//000 ADD
			3'b001 : begin //001 SUB
				Out = {OutSumador[7],OutSumador[6],OutSumador[5],OutSumador[4],OutSumador[3],
						OutSumador[2],OutSumador[1],OutSumador[0]};
				C <= CSumador[0];
				V <= VSumador[0];
				
			end
			3'b010 : begin   // MULT
				Out = {OutMULT,OutMULT,OutMULT,OutMULT,OutMULT,OutMULT,OutMULT,OutMULT};
				C <= CMULT;
				V <= VMULT;
				
			end
			3'b011 :begin
				Out = {OutDIV,OutDIV ,OutDIV,OutDIV,OutDIV,OutDIV,OutDIV,OutDIV}; // Div
				C <= CDIV;
				V <= VDIV;
				
			end
			3'b100 : begin  // MOD
				Out = {OutMOD,OutMOD,OutMOD,OutMOD,OutMOD,OutMOD,OutMOD,OutMOD };
				C <= CMOD;
				V <= VMOD;
				
			end
			3'b101 : begin 
				Out = {OutShiftL,OutShiftL,OutShiftL,OutShiftL,OutShiftL,OutShiftL,OutShiftL,OutShiftL};
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
	
		
		
   end
	
endmodule