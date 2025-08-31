/*
* @file memory.sv 
* @brief Consists of program data and RAM for application
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/12/2025
*/

`timescale 1ns/1ps

module memory (
  input         clk_i,
  input         rst_ni,

  input  [31:0] mem_addr_i,
  output [31:0] mem_rd_data_o,

  input         mem_wr_en_i,
  input  [31:0] mem_wr_data_i,

  input  [31:0] disp_addr_i,
  output [31:0] disp_dat_o
);

localparam ROM_DEPTH = 256; //Implementing minimal memory for simplicity
localparam RAM_DEPTH = 256;

logic [31:0] mem_d[((ROM_DEPTH + RAM_DEPTH) - 1):0];
logic [31:0] addr;
logic [31:0] disp_addr;

assign addr = {2'b00, mem_addr_i[31:2]};
assign disp_addr = {2'b00, disp_addr_i[31:2]};

initial begin
  $readmemh("../TB/rom_init.hex", mem_d, 0, ROM_DEPTH-1);
end

always_ff @(posedge clk_i or negedge rst_ni) begin
  if (!rst_ni) begin
    for (int i = RAM_DEPTH; i < (ROM_DEPTH + RAM_DEPTH); i = i + 1) begin
      mem_d[i] <= 'h0;
    end
  end else if (mem_wr_en_i && (addr >= ROM_DEPTH)) begin
    mem_d[addr] <= mem_wr_data_i;
  end
end

assign mem_rd_data_o = mem_d[addr];
assign disp_dat_o    = mem_d[disp_addr];

endmodule