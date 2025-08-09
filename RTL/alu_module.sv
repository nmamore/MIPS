/*
* @file alu_module.sv 
* @brief Perform arithmetic and logical functions on operands
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/6/2025
*/

localparam OP_AND   = 3'h0;
localparam OP_OR    = 3'h1;
localparam OP_ADD   = 3'h2;
localparam OP_ANDBN = 3'h4;
localparam OP_ORBN  = 3'h5;
localparam OP_SUB   = 3'h6;
localparam OP_SLT   = 3'h7;

module control_unit (
  input  [2:0]  opcode_i,
  
  output [31:0] operand_a_i,
  output [31:0] operand_b_i,
  
  output        zero_flag_o,
  output [31:0] result_o
);

logic [31:0] operand_a;
logic [31:0] operand_b;
logic [31:0] alu_out;
logic [31:0] temp;
logic [2:0]  op_val;

assign op_val    = opcode_i;
assign operand_a = operand_a_i;
assign operand_b = operand_b_i;

always_comb begin
  unique case (op_val)
    OP_AND: begin
      alu_out = operand_a & operand_b;
    end
    OP_OR: begin
      alu_out = operand_a | operand_b;
    end
    OP_ADD: begin
      alu_out = operand_a + operand_b;
    end
    OP_ANDBN: begin
      alu_out = operand_a & (~operand_b);
    end
    OP_ORBN: begin
      alu_out = operand_a | (~operand_b);
    end
    OP_SUB: begin
      alu_out = operand_a - operand_b;
    end
    OP_SLT: begin
      if (operand_a[31] ^ operand_b[31]) begin
        alu_out = 32'h00000001;
      end else begin
        temp = operand_a - operand_b;
        alu_out = {31'h00000000, temp[31]};
      end
    end
    default: begin
      alu_out = 'h0;
    end
  endcase
end

assign result_o    = alu_out;
assign zero_flag_o = ~(|alu_out);

endmodule