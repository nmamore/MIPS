/*
* @file topMIPS.sv 
* @brief Top level of MIPS architecture implementation
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/1/2025
*/

`timescale 1ns/1ps

module topMIPS (
  input        clk_i,
  input        clk_btn_ni,
  input        rst_ni,
  
  output [7:0] hex_0_o,
  output [7:0] hex_1_o,
  output [7:0] hex_2_o,
  output [7:0] hex_3_o,
  output [7:0] hex_4_o,
  output [7:0] hex_5_o,
  
  input        sw_0_i,
  input        sw_1_i,
  input        sw_2_i,
  input        sw_3_i,
  input        sw_4_i,
  input        sw_5_i,
  input        sw_6_i,
  input        sw_7_i,
  input        sw_8_i,
  input        sw_9_i,
  
  output       led_r_0_o,
  output       led_r_1_o,
  output       led_r_2_o,
  output       led_r_3_o,
  output       led_r_4_o,
  output       led_r_5_o,
  output       led_r_6_o,
  output       led_r_7_o,
  output       led_r_8_o,
  output       led_r_9_o
);

//General Signals

logic        mclk;
logic        sync_rst_n;
logic        sync_clk_btn_n;

logic [9:0]  led_array;
logic        sync_sw_0, sync_sw_1, sync_sw_2, sync_sw_3, sync_sw_4, sync_sw_5, sync_sw_6, sync_sw_7, sync_sw_8, sync_sw_9;
logic [9:0]  sw_array;
logic [31:0] disp_dat;
logic [15:0] ram_dat;
logic [31:0] disp_addr;
logic        clk_sel;
logic        nibble_sel;

assign sw_array   = {sync_sw_9, sync_sw_8, sync_sw_7, sync_sw_6, sync_sw_5, sync_sw_4, sync_sw_3, sync_sw_2, sync_sw_1, sync_sw_0};
assign led_array  = (sw_array[9:0]);
assign disp_addr  = {22'h000000, sw_array[9:2], 2'b00};
assign clk_sel    = sw_array[0];
assign nibble_sel = sw_array[1];

assign ram_dat = (nibble_sel) ? disp_dat[31:16]:
                                disp_dat[15:0];
                                
assign mclk = (clk_sel) ? ~sync_clk_btn_n:
                           clk_i;

assign led_r_0_o = led_array[0];
assign led_r_1_o = led_array[1];
assign led_r_2_o = led_array[2];
assign led_r_3_o = led_array[3];
assign led_r_4_o = led_array[4];
assign led_r_5_o = led_array[5];
assign led_r_6_o = led_array[6];
assign led_r_7_o = led_array[7];
assign led_r_8_o = led_array[8];
assign led_r_9_o = led_array[9];

//Control Signals
logic [5:0]  opcode;
logic [5:0]  funct;
logic [2:0]  alu_op;
logic        reg_wr_en;
logic        reg_wr_addr_src;
logic        reg_wr_data_src;
logic        alu_operand_b_src;
logic        branch;
logic        jump;

//Instruction Memory Signals
logic [31:0] inst_out;

//PC Signals
logic [31:0] pc_in;
logic [31:0] pc_out;
logic [31:0] pc_next;
logic [31:0] pc_shift;
logic [31:0] pc_branch;
logic [31:0] pc_jta;
logic        pc_src;

//Register file signals
logic [4:0]  reg_rd_addr_1;
logic [31:0] reg_rd_data_1;
logic [4:0]  reg_rd_addr_2;
logic [31:0] reg_rd_data_2;
logic [4:0]  reg_wr_addr;
logic [31:0] reg_wr_data;

//Sign Extension
logic [31:0] sign_imm; //Sign extended immediate

//ALU signals
logic [31:0] alu_operand_b;
logic [31:0] alu_result;
logic        f_zero;

//Data memory signals
logic [31:0] dat_mem_rd_dat;
logic        dat_mem_wr_en;

//Instruction Signal Routing
assign opcode           = inst_out[31:26];
assign reg_rd_addr_1    = inst_out[25:21]; //Read address of Rs
assign reg_rd_addr_2    = inst_out[20:16]; //Read address of Rt
assign reg_wr_addr      = (reg_wr_addr_src) ? inst_out[15:11]: //Set write address to Rd
                                              inst_out[20:16]; //or Rt
assign sign_imm [15:0]  = inst_out[15:0];  //Set least significant nibble to immediate

assign sign_imm [31:16] = {16{inst_out[15]}};    //Sign extend immediate
assign funct            = inst_out[5:0];

//Write register data routing
assign reg_wr_data = (reg_wr_data_src) ? dat_mem_rd_dat: //Set register write data to data memory output
                                         alu_result;      //Or ALU result
//ALU Source B routing
assign alu_operand_b = (alu_operand_b_src) ? sign_imm:      //Set ALU operand B to sign-extended immediate
                                             reg_rd_data_2; //or register read data 2

//Program Counter Incrementation/Branching
assign pc_next = pc_out + 32'h00000004; //Generates next instruction address

assign pc_src = branch & f_zero; //Logic for determining if PC will branch

assign pc_jta = {pc_next[31:28], inst_out[25:0], 2'b00}; //Sets up address PC will jump to
assign pc_shift = {sign_imm[29:0], 2'b00} + pc_next; //Multiplies immediate address by 4 for word alignment, adds to next instruction location

assign pc_branch =(pc_src) ? pc_shift: //Sets potential PC to branch location
                             pc_next; //or next instruction
assign pc_in = (jump) ? pc_jta: //Sets PC to jump address
                           pc_branch; //or branch location or next instruction
control_unit control (
  .opcode_i           (opcode),
  .funct_i            (funct),
  
  .alu_op_o           (alu_op),
  .reg_wr_en_o        (reg_wr_en),
  .dat_mem_wr_en_o    (dat_mem_wr_en),
  
  .reg_wr_addr_src_o  (reg_wr_addr_src),
  .reg_wr_data_src_o  (reg_wr_data_src),
  .alu_operand_b_src_o(alu_operand_b_src),
  .branch_o           (branch),
  .jump_o             (jump)
);

program_counter pc (
  .clk_i       (mclk),
  .rst_ni      (sync_rst_n),
  
  .pc_next_i   (pc_in),
  .pc_current_o(pc_out)
);

instruction_memory inst_mem (
  .inst_mem_addr_i(pc_out),
  .inst_mem_data_o(inst_out)
);

register_file reg_file (
  .clk_i      (mclk),
  .rst_ni     (sync_rst_n),
  
  .rd_addr_1_i(reg_rd_addr_1),
  .rd_dat_1_o (reg_rd_data_1),
  
  .rd_addr_2_i(reg_rd_addr_2),
  .rd_dat_2_o (reg_rd_data_2),
  
  .wr_en_i    (reg_wr_en),
  .wr_addr_i  (reg_wr_addr),
  .wr_data_i  (reg_wr_data)
);

alu_module alu (
  .opcode_i   (alu_op),
  .operand_a_i(reg_rd_data_1),
  .operand_b_i(alu_operand_b),
  
  .zero_flag_o(f_zero),
  .result_o   (alu_result)
);

data_memory data_mem (
  .clk_i         (mclk),
  .rst_ni        (sync_rst_n),
  
  .data_address_i(alu_result),
  .address_data_o(dat_mem_rd_dat),
  
  .wr_en_i       (dat_mem_wr_en),
  .wr_dat_i      (reg_rd_data_2),
  
  .disp_addr_i   (disp_addr),
  .disp_dat_o    (disp_dat)
);

sev_seg_display hex0 (
  .dat_i      (ram_dat[3:0]),
  .seven_seg_o(hex_0_o)
);

sev_seg_display hex1 (
  .dat_i      (ram_dat[7:4]),
  .seven_seg_o(hex_1_o)
);

sev_seg_display hex2 (
  .dat_i      (ram_dat[11:8]),
  .seven_seg_o(hex_2_o)
);

sev_seg_display hex3 (
  .dat_i      (ram_dat[15:12]),
  .seven_seg_o(hex_3_o)
);

sev_seg_display hex4 (
  .dat_i      (pc_out[3:0]),
  .seven_seg_o(hex_4_o)
);

sev_seg_display hex5 (
  .dat_i      (pc_out[7:4]),
  .seven_seg_o(hex_5_o)
);

sync sw_0_sync (
  .clk_i  (clk_i),
  .async_i(sw_0_i),
  .sync_o (sync_sw_0)
);

sync sw_1_sync (
  .clk_i  (clk_i),
  .async_i(sw_1_i),
  .sync_o (sync_sw_1)
);

sync sw_2_sync (
  .clk_i  (clk_i),
  .async_i(sw_2_i),
  .sync_o (sync_sw_2)
);

sync sw_3_sync (
  .clk_i  (clk_i),
  .async_i(sw_3_i),
  .sync_o (sync_sw_3)
);

sync sw_4_sync (
  .clk_i  (clk_i),
  .async_i(sw_4_i),
  .sync_o (sync_sw_4)
);

sync sw_5_sync (
  .clk_i  (clk_i),
  .async_i(sw_5_i),
  .sync_o (sync_sw_5)
);

sync sw_6_sync (
  .clk_i  (clk_i),
  .async_i(sw_6_i),
  .sync_o (sync_sw_6)
);

sync sw_7_sync (
  .clk_i  (clk_i),
  .async_i(sw_7_i),
  .sync_o (sync_sw_7)
);

sync sw_8_sync (
  .clk_i  (clk_i),
  .async_i(sw_8_i),
  .sync_o (sync_sw_8)
);

sync sw_9_sync (
  .clk_i  (clk_i),
  .async_i(sw_9_i),
  .sync_o (sync_sw_9)
);

sync rst_sync (
  .clk_i  (clk_i),
  .async_i(rst_ni),
  .sync_o (sync_rst_n)
);

sync clk_btn_sync (
  .clk_i  (clk_i),
  .async_i(clk_btn_ni),
  .sync_o (sync_clk_btn_n)
);

endmodule