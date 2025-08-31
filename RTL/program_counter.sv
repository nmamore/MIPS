/*
* @file program_counter.sv 
* @brief Stores the address of the next instruction to be executed
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/6/2025
*/

`timescale 1ns/1ps

module program_counter (
  input         clk_i,
  input         rst_ni,
  
  input         pc_wr_en_i,
  
  input  [31:0] pc_next_i,
  output [31:0] pc_current_o
  
);

logic [31:0] data_d, data_q;

assign data_d = pc_next_i;

always_ff @(posedge clk_i or negedge rst_ni) begin
  if (!rst_ni) begin
    data_q <= '0;
  end else if (pc_wr_en_i) begin
    data_q <= data_d;
  end
end

assign pc_current_o = data_q;

endmodule