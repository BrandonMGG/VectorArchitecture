module dmem_ram(input logic switchStart, clk, we,
                input logic [31:0] address, wd,
                output logic [31:0] rd);

    logic [31:0] dmem_RAM[0:129599];
    always @(switchStart)
    $writememh("/home/guillen/Documents/GitHub/lguillen2_computer-architecture_1_2023/procesador-pipeline/imageOutput.txt", dmem_RAM);


    // Escribe en memoria 
    always_ff @(posedge clk)
        begin
            if (we) 
                begin
                    if (address >= 'd0 && address <= 'd129599)
                        begin
                        dmem_RAM[address] <= wd;
                        end


                end
        end
    assign rd = {31'b0, dmem_RAM[address]};





endmodule