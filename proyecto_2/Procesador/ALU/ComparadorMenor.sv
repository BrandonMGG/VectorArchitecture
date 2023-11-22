module ComparadorMenor #(parameter WIDTH = 8)( input[WIDTH-1:0] entrada1, entrada2,
  output logic [WIDTH-1:0] resultado);

  assign resultado = (entrada1 <= entrada2) ? 'h1 : 'h0;

endmodule