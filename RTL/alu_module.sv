/*
* @file alu_module.sv 
* @brief Perform arithmetic and logical functions on operands
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/6/2025
*/

module control_unit (
  input  [2:0]  opcode_i,
  
  output [31:0] operand_a_i,
  output [31:0] operand_b_i,
  
  output        zero_flag_o,
  output [31:0] result_o
);

typedef enum logic [2:0] {
  OP_ADD = 3'h2,
  OP_SUB = 3'h3,
  OP_AND = 3'h4,
  OP_OR  = 3'h5,
  OP_SLT = 3'h6
} opcode_e;
opcode_e op_val;

logic [31:0] operand_a;
logic [31:0] operand_b;
logic [31:0] alu_out;

assign op_val    = opcode_i
assign operand_a = operand_a_i;
assign operand_b = operand_b_i;

always_comb begin
  unique case (op_val)
    OP_ADD: begin
      alu_out = operand_a + operand_b;
    end
    OP_SUB: begin
      alu_out = operand_a - operand_b;
    end
    OP_AND: begin
      alu_out = operand_a & operand_b;
    end
    OP_OR: begin
      alu_out = operand_a | operand_b;
    end
    OP_SLT: begin

    end
    default: begin
      alu_out = 'h0;
    end
  endcase
end

assign result_o    = alu_out;
assign zero_flag_o = ~(alu_out != '0);

endmodule