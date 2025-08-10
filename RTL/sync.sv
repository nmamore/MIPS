/*
* @file sync.sv
* @brief 2FF to generate a synchronous signal from async input
* @author Nicholas Amore namore7@gmail.com
* @date Created 8/9/2025
*/

module sync (
  input  logic clk_i,
  input  logic async_i,
  output logic sync_o
);

logic ff_1_d, ff_2_d;
logic ff_1_q, ff_2_q;

assign ff_1_d = async_i;

always_ff @(posedge clk_i) begin
  ff_1_q <= ff_1_d;
end

assign ff_2_d = ff_1_q;
  
always_ff @(posedge clk_i) begin
  ff_2_q <= ff_2_d;
end

assign sync_o = ff_2_q;

endmodule