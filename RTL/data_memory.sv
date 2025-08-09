/*
* @file data_memory.sv 
* @brief RAM for use with program
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/7/2025
*/

`timescale 1ns/1ps

localparam DEPTH = 64; //Implementing minimal memory for simplicity

module data_memory (
  input         clk_i,
  input         rst_ni,
  
  input  [31:0] data_address_i,
  output [31:0] address_data_o,
  
  input         wr_en_i,
  input  [31:0] wr_dat_i
);

logic [31:0] ram_d[DEPTH-1:0];
logic [31:0] addr;
logic [31:0] wr_dat;
logic        wr_en;

assign addr   = data_address_i;
assign wr_en  = wr_en_i;
assign wr_dat = wr_dat_i;


always_ff @(posedge clk_i or negedge rst_ni) begin
  if (!rst_ni) begin
    for (int i = 0; i < DEPTH; i = i + 1) begin
      ram_d[i] <= 'h0;
    end
  end else if (wr_en) begin
    ram_d[{2'b00, addr[31:2]}] <= wr_dat;
  end
end

assign address_data_o = ram_d[{2'b00, addr[31:2]}];

endmodule