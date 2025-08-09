/*
* @file control_unit.sv 
* @brief Decodes opcodes into timing and control signals
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/6/2025
*/

//Opcode Constants
localparam OP_R    = 6'h00;
localparam OP_J    = 6'h02;
localparam OP_BEQ  = 6'h04;
localparam OP_ADDI = 6'h08;
localparam OP_LDW  = 6'h23;
localparam OP_STW  = 6'h2B;

//R Opcode Function Constants
localparam R_ADD = 6'h20;
localparam R_SUB = 6'h22;
localparam R_AND = 6'h24;
localparam R_OR  = 6'h25;
localparam R_SLT = 6'h2A;

module control_unit (
  input  [5:0] opcode_i,
  input  [5:0] funct_i,
  
  output [2:0] alu_op_o,
  output       reg_wr_en_o,
  output       dat_mem_wr_en_o,
  
  output       reg_wr_addr_src_o,
  output       reg_wr_data_src_o,
  output       alu_operand_b_src_o,
  output       branch_o,
  output       jump_o
);

typedef enum logic [2:0] {
  ALU_AND = 3'h0,
  ALU_OR  = 3'h1,
  ALU_ADD = 3'h2,
  ALU_SUB = 3'h6,
  ALU_SLT = 3'h7
} alu_opcode_e;
alu_opcode_e alu_op;

logic [5:0] op_val;
logic [5:0] funct_val;
logic       reg_wr_en;
logic       dat_mem_wr_en;
logic       reg_wr_addr_src;
logic       reg_wr_data_src;
logic       alu_operand_b_src;
logic       branch;
logic       jump;

assign op_val = opcode_i;
assign funct_val = funct_i;

always_comb begin
  unique case (op_val)
    OP_R: begin
      unique case (funct_val)
        R_ADD: begin
          alu_op = ALU_ADD;
          reg_wr_en = 1'b1;
          dat_mem_wr_en = 1'b0;
          reg_wr_addr_src = 1'b1;
          reg_wr_data_src = 1'b0;
          alu_operand_b_src = 1'b0;
          branch = 1'b0;
          jump = 1'b0;
        end
        R_SUB: begin
          alu_op = ALU_SUB;
          reg_wr_en = 1'b1;
          dat_mem_wr_en = 1'b0;
          reg_wr_addr_src = 1'b1;
          reg_wr_data_src = 1'b0;
          alu_operand_b_src = 1'b0;
          branch = 1'b0;
          jump = 1'b0;
        end
        R_AND: begin
          alu_op = ALU_AND;
          reg_wr_en = 1'b1;
          dat_mem_wr_en = 1'b0;
          reg_wr_addr_src = 1'b1;
          reg_wr_data_src = 1'b0;
          alu_operand_b_src = 1'b0;
          branch = 1'b0;
          jump = 1'b0;
        end
        R_OR: begin
          alu_op = ALU_OR;
          reg_wr_en = 1'b1;
          dat_mem_wr_en = 1'b0;
          reg_wr_addr_src = 1'b1;
          reg_wr_data_src = 1'b0;
          alu_operand_b_src = 1'b0;
          branch = 1'b0;
          jump = 1'b0;
        end
        R_SLT: begin
          alu_op = ALU_SLT;
          reg_wr_en = 1'b1;
          dat_mem_wr_en = 1'b0;
          reg_wr_addr_src = 1'b1;
          reg_wr_data_src = 1'b0;
          alu_operand_b_src = 1'b0;
          branch = 1'b0;
          jump = 1'b0;
        end
        default: begin
          alu_op = ALU_ADD;
          reg_wr_en = 1'b0;
          dat_mem_wr_en = 1'b0;
          reg_wr_addr_src = 1'b0;
          reg_wr_data_src = 1'b0;
          alu_operand_b_src = 1'b0;
          branch = 1'b0;
          jump = 1'b0;
        end
      endcase
    end
    OP_J: begin
      alu_op = ALU_ADD;
      reg_wr_en = 1'b0;
      dat_mem_wr_en = 1'b0;
      reg_wr_addr_src = 1'b0;
      reg_wr_data_src = 1'b0;
      alu_operand_b_src = 1'b0;
      branch = 1'b0;
      jump = 1'b1;
    end
    OP_BEQ: begin
      alu_op = ALU_SUB;
      reg_wr_en = 1'b0;
      dat_mem_wr_en = 1'b0;
      reg_wr_addr_src = 1'b0;
      reg_wr_data_src = 1'b0;
      alu_operand_b_src = 1'b1;
      branch = 1'b1;
      jump = 1'b0;
    end
    OP_ADDI: begin
      alu_op = ALU_ADD;
      reg_wr_en = 1'b1;
      dat_mem_wr_en = 1'b0;
      reg_wr_addr_src = 1'b0;
      reg_wr_data_src = 1'b0;
      alu_operand_b_src = 1'b1;
      branch = 1'b0;
      jump = 1'b0;
    end
    OP_LDW: begin
      alu_op = ALU_ADD;
      reg_wr_en = 1'b1;
      dat_mem_wr_en = 1'b0;
      reg_wr_addr_src = 1'b0;
      reg_wr_data_src = 1'b1;
      alu_operand_b_src = 1'b1;
      branch = 1'b0;
      jump = 1'b0;
    end
    OP_STW: begin
      alu_op = ALU_ADD;
      reg_wr_en = 1'b0;
      dat_mem_wr_en = 1'b1;
      reg_wr_addr_src = 1'b0;
      reg_wr_data_src = 1'b1;
      alu_operand_b_src = 1'b1;
      branch = 1'b0;
      jump = 1'b0;
    end
    default: begin
      alu_op = ALU_ADD;
      reg_wr_en = 1'b0;
      dat_mem_wr_en = 1'b0;
      reg_wr_addr_src = 1'b0;
      reg_wr_data_src = 1'b0;
      alu_operand_b_src = 1'b0;
      branch = 1'b0;
      jump = 1'b0;
    end
  endcase
end

assign alu_op_o    = alu_op;
assign reg_wr_en_o = reg_wr_en;
assign dat_mem_wr_en_o = dat_mem_wr_en;
assign reg_wr_addr_src_o = reg_wr_addr_src;
assign reg_wr_data_src_o = reg_wr_data_src;
assign alu_operand_b_src_o = alu_operand_b_src;
assign branch_o = branch;
assign jump_o = jump;

endmodule