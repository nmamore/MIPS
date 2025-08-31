/*
* @file register_file.sv 
* @brief 32 registers for use with MIPS architecture. Can read out two registers and write one
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/6/2025
*/

`timescale 1ns/1ps

localparam SIZE = 32;

module register_file (
  input         clk_i,
  input         rst_ni,

  input  [4:0]  rd_addr_1_i,
  output [31:0] rd_dat_1_o,
  
  input  [4:0]  rd_addr_2_i,
  output [31:0] rd_dat_2_o,
  
  input         wr_en_i,
  input  [4:0]  wr_addr_i,
  input  [31:0] wr_dat_i
);

logic [4:0] reg_addr_1;
logic [4:0] reg_addr_2;
logic [4:0] wr_addr;

logic [31:0] reg_data_d[0:(SIZE-1)];
logic [31:0] wr_data;

logic        wr_en;

assign reg_addr_1 = rd_addr_1_i;
assign reg_addr_2 = rd_addr_2_i;

assign wr_en      = wr_en_i;
assign wr_addr    = wr_addr_i;
assign wr_data    = wr_dat_i;


always_ff @(posedge clk_i or negedge rst_ni) begin
  if (!rst_ni) begin
    for (int i = 0; i < SIZE; i = i + 1) begin
      reg_data_d[i] <= 'h0; 
    end
  end else if (wr_en) begin
    reg_data_d[wr_addr] <= wr_data;
  end
end

assign rd_dat_1_o = reg_data_d[reg_addr_1];
assign rd_dat_2_o = reg_data_d[reg_addr_2];

endmodule