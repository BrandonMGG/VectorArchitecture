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
	
	logic [VECTOR_WIDTH-1:0] [WIDTH-1:0] OutMULT;
	logic [VECTOR_WIDTH-1:0] CMULT,VMULT;

	multiplicador #( WIDTH ) MULT0 (A[0],B[0],OutMULT[0],VMULT[0],CMULT[0]);
	multiplicador #( WIDTH ) MULT1 (A[1],B[1],OutMULT[1],VMULT[1],CMULT[1]);
	multiplicador #( WIDTH ) MULT2 (A[2],B[2],OutMULT[2],VMULT[2],CMULT[2]);
	multiplicador #( WIDTH ) MULT3 (A[3],B[3],OutMULT[3],VMULT[3],CMULT[3]);
	multiplicador #( WIDTH ) MULT4 (A[4],B[4],OutMULT[4],VMULT[4],CMULT[4]);
	multiplicador #( WIDTH ) MULT5 (A[5],B[5],OutMULT[5],VMULT[5],CMULT[5]);
	multiplicador #( WIDTH ) MULT6 (A[6],B[6],OutMULT[6],VMULT[6],CMULT[6]);
	multiplicador #( WIDTH ) MULT7 (A[7],B[7],OutMULT[7],VMULT[7],CMULT[7]);

	/*
	//=============DIV=============
	
	logic [WIDTH-1:0] OutDIV;
	logic CDIV,VDIV;

	divisor #( WIDTH ) DIV(A[0],B[0],OutDIV,VDIV,CDIV);	
	
	
	//=============MOD=============
	
	logic [WIDTH-1:0] OutMOD;
	logic CMOD,VMOD;

	modulo #( WIDTH ) MOD(A[0],B[0],OutMOD,VMOD,CMOD);		
	

	*/
	//=============AND=============
	
	logic [VECTOR_WIDTH-1:0] [WIDTH-1:0] OutAND;
	logic [VECTOR_WIDTH-1:0] CAND,VAND;

	and_modulo #( WIDTH ) AND0 (A[0],B[0],OutAND[0],VAND[0],CAND[0]);
	and_modulo #( WIDTH ) AND1 (A[1],B[1],OutAND[1],VAND[1],CAND[1]);
	and_modulo #( WIDTH ) AND2 (A[2],B[2],OutAND[2],VAND[2],CAND[2]);
	and_modulo #( WIDTH ) AND3 (A[3],B[3],OutAND[3],VAND[3],CAND[3]);
	and_modulo #( WIDTH ) AND4 (A[4],B[4],OutAND[4],VAND[4],CAND[4]);
	and_modulo #( WIDTH ) AND5 (A[5],B[5],OutAND[5],VAND[5],CAND[5]);
	and_modulo #( WIDTH ) AND6 (A[6],B[6],OutAND[6],VAND[6],CAND[6]);
	and_modulo #( WIDTH ) AND7 (A[7],B[7],OutAND[7],VAND[7],CAND[7]);
	
	//=============OR=============
	/*
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
	
	
	//=============CMP=============
	
	logic [VECTOR_WIDTH-1:0] [WIDTH-1:0] OutCMP;
	ComparadorMenor #(WIDTH) ComparadorMenor0 (A[0],B[0],OutCMP[0]);
	ComparadorMenor #(WIDTH) ComparadorMenor1 (A[1],B[1],OutCMP[1]);
	ComparadorMenor #(WIDTH) ComparadorMenor2 (A[2],B[2],OutCMP[2]);
	ComparadorMenor #(WIDTH) ComparadorMenor3 (A[3],B[3],OutCMP[3]);
	ComparadorMenor #(WIDTH) ComparadorMenor4 (A[4],B[4],OutCMP[4]);
	ComparadorMenor #(WIDTH) ComparadorMenor5 (A[5],B[5],OutCMP[5]);
	ComparadorMenor #(WIDTH) ComparadorMenor6 (A[6],B[6],OutCMP[6]);
	ComparadorMenor #(WIDTH) ComparadorMenor7 (A[7],B[7],OutCMP[7]);

	always_comb begin  
	
      case (sel)  
         3'b000,			//000 ADD
			3'b001 : begin //001 SUB
				Out = {OutSumador[7],OutSumador[6],OutSumador[5],OutSumador[4],OutSumador[3],
						OutSumador[2],OutSumador[1],OutSumador[0]};
				C <= 0;
				V <= 0;
				Z <= 0;
				N <= 0;
				
			end
			3'b010 : begin   // MULT
				Out = {OutMULT[7],OutMULT[6],OutMULT[5],OutMULT[4],OutMULT[3],OutMULT[2],OutMULT[1],OutMULT[0]};
				C <= 0;
				V <= 0;
				Z <= 0;
				N <= 0;
				
			end
			3'b011 :begin
				Out = {OutAND[7],OutAND[6] ,OutAND[5],OutAND[4],OutAND[3],OutAND[2],OutAND[1],OutAND[0]}; // and
				C <= 0;
				V <= 0;
				Z <= 0;
				N <= 0;
				
			end
			3'b100 : begin  // cmp
				Out = {OutCMP[7],OutCMP[6],OutCMP[5],OutCMP[4],OutCMP[3],OutCMP[2],OutCMP[1],OutCMP[0] };
				C <= 0;
				V <= 0;
				Z <= 0;
				N <= 0;
				
			end
			3'b101 : begin 
				Out = {OutShiftL,OutShiftL,OutShiftL,OutShiftL,OutShiftL,OutShiftL,OutShiftL,OutShiftL};
				C <= 0;
				V <= 0;
				Z <= 0;
				N <= 0;
				
			end
			3'b110 : begin // GUESS: bypass the ALU and put the A value in the output
				Out = A;
				C <= 0;
				V <= 0;
				Z <= 0;
				N <= 0;

			end
			3'b111 : begin // GUESS:  bypass the ALU and put the B value in the output
				Out = B;
				C <= 0;
				V <= 0;
				Z <= 0;
				N <= 0;

			end
			default : begin
				Out = A;
				C <= 0;
				V <= 0;
				Z <= 0;
				N <= 0;
				
			end
      endcase 
	
		
		
   end
	
endmodule