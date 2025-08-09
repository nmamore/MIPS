/*
* @file topMIPS.sv 
* @brief Top level of MIPS architecture implementation
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/1/2025
*/

module topMIPS (
  input clk_i,
  input rst_ni
);

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
assign sign_imm [31:16] = inst_out[15];    //Sign extend immediate
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
assign pc_shift = {sign_imm[31:2], 2'b00} + pc_next; //Multiplies immediate address by 4 for word alignment, adds to next instruction location

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
  .clk_i       (clk_i),
  .rst_ni      (rst_ni),
  
  .pc_next_i   (pc_in),
  .pc_current_o(pc_out)
);

instruction_memory inst_mem (
  .inst_mem_addr_i(pc_out),
  .inst_mem_data_o(inst_out)
);

register_file reg_file (
  .clk_i      (clk_i),
  .rst_ni     (rst_ni),
  
  .rd_addr_1_i(reg_rd_addr_1),
  .rd_dat_1_o (reg_rd_data_1),
  
  .rd_addr_2_i(reg_rd_addr_2),
  .rd_dat_2_o (reg_rd_data_2),
  
  .wr_en_i    (reg_wr_en),
  .wr_addr_i  (reg_wr_addr),
  .wr_data_i  (reg_wr_data)
);

alu_module alu (
  .opcode_i   (alu_control),
  .operand_a_i(reg_rd_data_1),
  .operand_b_i(alu_operand_b),
  
  .zero_flag_o(f_zero),
  .result_o   (alu_result)
);

data_memory data_mem (
  .clk_i         (clk_i),
  .rst_ni        (rst_ni),
  
  .data_address_i(alu_result),
  .address_data_o(dat_mem_rd_dat),
  
  .wr_en_i       (dat_mem_wr_en),
  .wr_dat_i      (reg_rd_data_2)
);

endmodule