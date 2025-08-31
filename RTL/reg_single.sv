/*
* @file reg_single.sv 
* @brief Single 32-bit register for multi-purpose applications
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/12/2025
*/

`timescale 1ns/1ps

module reg_single (
  input         clk_i,
  input         rst_ni,

  input         wr_en_i,
  input  [31:0] reg_dat_i,
  output [31:0] reg_dat_o
);

logic [31:0] reg_dat_q;

always_ff @(posedge clk_i or negedge rst_ni) begin
  if (!rst_ni) begin
    reg_dat_q <= 'h0;
  end else if (wr_en_i) begin
    reg_dat_q <= reg_dat_i;
  end
end

assign reg_dat_o = reg_dat_q;

endmodule