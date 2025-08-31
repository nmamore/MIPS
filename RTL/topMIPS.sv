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

//Signal Declarations

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

//Control Signals
logic [5:0]  opcode;
logic [5:0]  funct;

logic        mem_addr_sel;
logic        mem_wr_en;

logic        ir_wr_en;

logic        reg_wr_en;
logic        reg_wr_addr_sel;
logic        reg_wr_dat_sel;

logic        alu_op_a_sel;
logic [1:0]  alu_op_b_sel;
logic [2:0]  alu_op;


logic [1:0]  pc_src_sel;
logic        cntl_branch;
logic        pc_wr_en;

//PC Signals
logic        pc_en;
logic [31:0] pc_next;
logic [31:0] pc_current;

//Memory Signals
logic [31:0] mem_addr;
logic [31:0] mem_dat_out;

//Data Register Signals
logic [31:0] inst_out;

//Instruction Register Signals
logic [31:0] dat_reg_out;

//Register file signals
logic [4:0]  reg_rd_addr_1;
logic [31:0] reg_rd_dat_1;
logic [4:0]  reg_rd_addr_2;
logic [31:0] reg_rd_dat_2;
logic [4:0]  reg_wr_addr;
logic [31:0] reg_wr_dat;

//A and B register signals
logic [31:0] reg_a_dat;
logic [31:0] reg_b_dat;

//Sign Extension
logic [31:0] sign_imm; //Sign extended immediate
logic [31:0] sign_imm_mult; //Sign immediate multiplied by 4

logic [31:0] j_addr; //Address for jump instruction

//ALU signals
logic [31:0] alu_operand_a;
logic [31:0] alu_operand_b;
logic [31:0] alu_result;
logic        f_zero;

//Accumulator Signals
logic [31:0] alu_out;

//Signal Assignments

//Memory address selection
assign mem_addr = (mem_addr_sel) ? alu_out:
                                   pc_current;

//Instruction Signal Routing
assign opcode           = inst_out[31:26];
assign reg_rd_addr_1    = inst_out[25:21]; //Read address of Rs
assign reg_rd_addr_2    = inst_out[20:16]; //Read address of Rt
assign reg_wr_addr      = (reg_wr_addr_sel) ? inst_out[15:11]: //Set write address to Rd
                                              inst_out[20:16]; //or Rt
assign sign_imm [15:0]  = inst_out[15:0];  //Set least significant nibble to immediate

assign sign_imm [31:16] = {16{inst_out[15]}};    //Sign extend immediate
assign funct            = inst_out[5:0];

//Address Extension for Jump
assign j_addr = {pc_current[31:28], inst_out[25:0], 2'b00};

//Sign Immediate routing
assign sign_imm_mult = {sign_imm[29:0], 2'b00};

//Write register data routing
assign reg_wr_dat = (reg_wr_dat_sel) ? dat_reg_out: //Set register write data to data memory output
                                       alu_out;     //Or ALU result
//ALU Source A routing
assign alu_operand_a = (alu_op_a_sel) ? reg_a_dat: //Set ALU operand A to current PC instruction
                                        pc_current;  //or to A register data

//ALU Source B routing
assign alu_operand_b = (alu_op_b_sel == 2'b00)  ? reg_b_dat:     //Set ALU operand B to B register data
                       (alu_op_b_sel == 2'b01)  ? 32'h00000004:  //or to 4
                       (alu_op_b_sel == 2'b10)  ? sign_imm:      //or to the signed immediate
                       (alu_op_b_sel == 2'b11)  ? sign_imm_mult: reg_b_dat; //or to the signed immediate multiplied by 4

//Program Counter Branching
assign pc_branch = cntl_branch & f_zero; //Logic for determining if PC will branch
assign pc_en  = pc_branch | pc_wr_en;    //Write address to PC if write or branch set

//Program Counter Next Address Selection
assign pc_next = (pc_src_sel == 2'b00) ? alu_result: //Set next PC address to ALU result
                 (pc_src_sel == 2'b01) ? alu_out:    //or value stored in accumulator
                 (pc_src_sel == 2'b10) ? j_addr: alu_result; //or jump address

//DE-10
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

control_unit control (
  .clk_i              (mclk),
  .rst_ni             (sync_rst_n),
  
  .opcode_i           (opcode),
  .funct_i            (funct),
  
  .mem_addr_sel_o     (mem_addr_sel),
  .mem_wr_en_o        (mem_wr_en),
  
  .ir_wr_en_o         (ir_wr_en),
  
  .reg_wr_en_o        (reg_wr_en),
  .reg_wr_addr_sel_o  (reg_wr_addr_sel),
  .reg_wr_dat_sel_o   (reg_wr_dat_sel),
  
  .alu_op_a_sel_o     (alu_op_a_sel),
  .alu_op_b_sel_o     (alu_op_b_sel),
  .alu_op_o           (alu_op),
  
  .pc_src_sel_o       (pc_src_sel),
  .cntl_branch_o      (cntl_branch),
  .pc_wr_en_o         (pc_wr_en)
);

program_counter pc (
  .clk_i       (mclk),
  .rst_ni      (sync_rst_n),
  
  .pc_wr_en_i  (pc_en),
  
  .pc_next_i   (pc_next),
  .pc_current_o(pc_current)
);

memory mem (
  .clk_i        (mclk),
  .rst_ni       (sync_rst_n),

  .mem_addr_i   (mem_addr),
  .mem_rd_data_o(mem_dat_out),

  .mem_wr_en_i  (mem_wr_en),
  .mem_wr_data_i(reg_b_dat),

  .disp_addr_i  (disp_addr),
  .disp_dat_o   (disp_dat)
);

reg_single inst_reg (
  .clk_i     (mclk),
  .rst_ni    (sync_rst_n),

  .wr_en_i   (ir_wr_en),
  .reg_dat_i (mem_dat_out),
  .reg_dat_o (inst_out)
);

reg_single dat_reg (
  .clk_i     (mclk),
  .rst_ni    (sync_rst_n),

  .wr_en_i   (1'b1),
  .reg_dat_i (mem_dat_out),
  .reg_dat_o (dat_reg_out)
);

register_file reg_file (
  .clk_i      (mclk),
  .rst_ni     (sync_rst_n),
  
  .rd_addr_1_i(reg_rd_addr_1),
  .rd_dat_1_o (reg_rd_dat_1),
  
  .rd_addr_2_i(reg_rd_addr_2),
  .rd_dat_2_o (reg_rd_dat_2),
  
  .wr_en_i    (reg_wr_en),
  .wr_addr_i  (reg_wr_addr),
  .wr_dat_i   (reg_wr_dat)
);

reg_single a_reg (
  .clk_i     (mclk),
  .rst_ni    (sync_rst_n),

  .wr_en_i   (1'b1),
  .reg_dat_i (reg_rd_dat_1),
  .reg_dat_o (reg_a_dat)
);

reg_single b_reg (
  .clk_i     (mclk),
  .rst_ni    (sync_rst_n),

  .wr_en_i   (1'b1),
  .reg_dat_i (reg_rd_dat_2),
  .reg_dat_o (reg_b_dat)
);

alu_module alu (
  .opcode_i   (alu_op),
  .operand_a_i(alu_operand_a),
  .operand_b_i(alu_operand_b),
  
  .zero_flag_o(f_zero),
  .result_o   (alu_result)
);

reg_single accumulator (
  .clk_i     (mclk),
  .rst_ni    (sync_rst_n),

  .wr_en_i   (1'b1),
  .reg_dat_i (alu_result),
  .reg_dat_o (alu_out)
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
  .dat_i      (pc_current[3:0]),
  .seven_seg_o(hex_4_o)
);

sev_seg_display hex5 (
  .dat_i      (pc_current[7:4]),
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