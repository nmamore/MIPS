/*
* @file tb_MIPS_top.sv 
* @brief Top level of MIPS test bench
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/9/2025
*/

`timescale 1ns/1ps

module tb_MIPS_top ();

localparam FPGA_CLK_SPEED = 20;

logic fpga_clk;
logic fpga_rst_n;
logic clk_btn_n;

logic [7:0] hex_0;
logic [7:0] hex_1;
logic [7:0] hex_2;
logic [7:0] hex_3;
logic [7:0] hex_4;
logic [7:0] hex_5;

logic led_r_0;
logic led_r_1;
logic led_r_2;
logic led_r_3;
logic led_r_4;
logic led_r_5;
logic led_r_6;
logic led_r_7;
logic led_r_8;
logic led_r_9;

logic [9:0] sw_array;

topMIPS uut (
  .clk_i(fpga_clk),
  .rst_ni(fpga_rst_n),
  .clk_btn_ni(clk_btn_n),
  
  .hex_0_o(hex_0),
  .hex_1_o(hex_1),
  .hex_2_o(hex_2),
  .hex_3_o(hex_3),
  .hex_4_o(hex_4),
  .hex_5_o(hex_5),
  
  .sw_0_i(sw_array[0]),
  .sw_1_i(sw_array[1]),
  .sw_2_i(sw_array[2]),
  .sw_3_i(sw_array[3]),
  .sw_4_i(sw_array[4]),
  .sw_5_i(sw_array[5]),
  .sw_6_i(sw_array[6]),
  .sw_7_i(sw_array[7]),
  .sw_8_i(sw_array[8]),
  .sw_9_i(sw_array[9]),
  
  .led_r_0_o(led_r_0),
  .led_r_1_o(led_r_1),
  .led_r_2_o(led_r_2),
  .led_r_3_o(led_r_3),
  .led_r_4_o(led_r_4),
  .led_r_5_o(led_r_5),
  .led_r_6_o(led_r_6),
  .led_r_7_o(led_r_7),
  .led_r_8_o(led_r_8),
  .led_r_9_o(led_r_9)
);

initial begin
  sw_array = '0;
  fpga_rst_n = 1'b0;
  clk_btn_n  = 1'b1;
  #200;
  fpga_rst_n = 1'b1;
  sw_array = 10'h050;
end

initial begin
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