module sine_lut(
  input logic signed [31:0] address,   // Puerto de entrada para la direccion de la tabla de búsqueda
  output logic signed [31:0] data      // Puerto de salida para el valor del seno calculado
);

  // Lookup table with precomputed sine values
  real lut[0:19] = '{0.00, 0.309016994374947, 0.587785252292473, 0.809016994374947,
                     0.951056516295153, 1.00, 0.951056516295154, 0.809016994374948,
                     0.587785252292473, 0.309016994374947, 0.00, -0.309016994374947,
                     -0.587785252292473, -0.809016994374947, -0.951056516295153, -1.00,
                     -0.951056516295154, -0.809016994374948, -0.587785252292473, -0.309016994374947};

  // Compute the sine value using the lookup table
  real x = $itor(address) / $itor(300) * $itor(4) + $itor(1);   // Convertir la direccion a un valor real en el rango [1, 5]
  int index = $floor(x);                                        // Redondear el valor real hacia abajo para obtener el indice de la entrada correspondiente en la tabla
  real frac = x - $itor(index);                                 // Calcular la fracción de la entrada que se encuentra entre las entradas correspondientes a los indices "index" y "index + 1"
  real sin1 = lut[index];                                       // Obtener el valor del seno correspondiente al indice "index"
  real sin2 = lut[index + 1];                                   // Obtener el valor del seno correspondiente al indice "index + 1"
  assign data = $itor(sin1 + frac * (sin2 - sin1));             // Calcular el valor del seno utilizando una formula de interpolacion lineal

endmodule
