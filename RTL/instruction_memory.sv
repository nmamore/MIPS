/*
* @file instruction_memory.sv 
* @brief Holds machine code of program
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/6/2025
*/

`include "program.svh"

parameter DEPTH = 64; //Implementing minimal memory for simplicity

module instruction_memory (
  input  [31:0] inst_mem_addr_i,
  output [31:0] inst_mem_data_o
);

logic [31:0] rom[DEPTH-1:0];
logic [31:0] addr;

initial begin
  $readmemh("../rom_init.hex", rom);
end

assign addr = inst_mem_addr_i;

assign inst_mem_data_o = rom[{addr[31:2], 2'b00}];

endmodule