/*
* @file tb_MIPS_top.sv 
* @brief Top level of MIPS test bench
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/9/2025
*/

`timescale 1ns/1ps

module tb_MIPS_top ();

localparam FPGA_CLK_SPEED = 50;

logic fpga_clk;
logic fpga_rstn;


topMIPS uut (
  .clk_i(fpga_clk),
  .rst_ni(fpga_rstn)
);

initial begin
  fpga_rstn = 1'b0;
  #200;
  fpga_rstn = 1'b1;
end

initial begin
  fpga_clk = 1'b0;
  #200;
  forever begin
    fpga_clk = 1'b1;
    #FPGA_CLK_SPEED;
    fpga_clk = 1'b0;
    #FPGA_CLK_SPEED;
  end
end

initial begin
  #10200;
  $stop;
end

endmodule