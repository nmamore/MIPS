/*
* @file control_unit.sv 
* @brief Decodes opcodes into timing and control signals
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/6/2025
*/

module control_unit (
  input  [5:0] opcode_i,
  input  [5:0] funct_i,
  
  output [2:0] alu_op_o,
  output       reg_wr_en_o,
  output       dat_mem_wr_en_o
  
  output       reg_wr_addr_src_o,
  output       reg_wr_data_src_o,
  output       alu_operand_b_src_o
);

typedef enum logic [5:0] {
  OP_R   = 6'h00,
  OP_LDW = 6'h23,
  OP_STW = 6'h2B
} opcode_e;
opcode_e op_val;

typedef enum logic [5:0] {
  RADD = 6'h20,
  RSUB = 6'h22,
  RAND = 6'h24,
  ROR  = 6'h25,
  RSLT = 6'h2A
} funct_e funct_val;

typedef enum logic [2:0] {
  ANOP = 3'h0,
  AADD = 3'h2,
  ASUB = 3'h3,
  AAND = 3'h4,
  AOR  = 3'h5,
  ASLT = 3'h6,
} alu_opcode_e;
alu_opcode_e alu_op;

logic       reg_wr_en;
logic       dat_mem_wr_en;
logic       reg_wr_addr_src;
logic       reg_wr_data_src;
logic       alu_operand_b_src;

assign op_val = opcode_i
assign funct_val = funct_i;

always_comb begin
  unique case (op_val)
    OP_R: begin
      unique case (funct_val) begin
        RADD: begin
          alu_op = AADD;
          reg_wr_en = 1'b1;
          dat_mem_wr_en = 1'b0;
          reg_wr_addr_src = 1'b1;
          reg_wr_data_src = 1'b0;
          alu_operand_b_src = 1'b0;
        end
        RSUB: begin
          alu_op = ASUB;
          reg_wr_en = 1'b1;
          dat_mem_wr_en = 1'b0;
          reg_wr_addr_src = 1'b1;
          reg_wr_data_src = 1'b0;
          alu_operand_b_src = 1'b0;
        end
        RAND: begin
          alu_op = AAND;
          reg_wr_en = 1'b1;
          dat_mem_wr_en = 1'b0;
          reg_wr_addr_src = 1'b1;
          reg_wr_data_src = 1'b0;
          alu_operand_b_src = 1'b0;        
        end
        ROR: begin
          alu_op = AOR;
          reg_wr_en = 1'b1;
          dat_mem_wr_en = 1'b0;
          reg_wr_addr_src = 1'b1;
          reg_wr_data_src = 1'b0;
          alu_operand_b_src = 1'b0;
        end
        RSLT: begin

        end
        default: begin
          alu_op = ANOP;
          reg_wr_en = 1'b0;
          dat_mem_wr_en = 1'b0;
          reg_wr_addr_src = 1'b0;
          reg_wr_data_src = 1'b0;
          alu_operand_b_src = 1'b0;
      endcase
    end
    OP_LDW: begin
      alu_op = AADD;
      reg_wr_en = 1'b1;
      dat_mem_wr_en = 1'b0;
      reg_wr_addr_src = 1'b0;
      reg_wr_data_src = 1'b1;
      alu_operand_b_src = 1'b1;
    end
    OP_STW: begin
      alu_op = AADD;
      reg_wr_en = 1'b0;
      dat_mem_wr_en = 1'b1;
      reg_wr_addr_src = 1'b0;
      reg_wr_data_src = 1'b1;
      alu_operand_b_src = 1'b1;
    end
    default: begin
      alu_op = ANOP;
      reg_wr_en = 1'b0;
      dat_mem_wr_en = 1'b0;
      reg_wr_addr_src = 1'b0;
      reg_wr_data_src = 1'b0;
      alu_operand_b_src = 1'b0;
    end
  endcase
end

assign alu_op_o    = alu_op;
assign reg_wr_en_o = reg_wr_en;
assign dat_mem_wr_en_o = dat_mem_wr_en;
assign reg_wr_addr_src_o = reg_wr_addr_src;
assign reg_wr_data_src_o = reg_wr_data_src;
assign alu_operand_b_src_o = alu_operand_b_src;

endmodule