/*
* @file control_unit.sv 
* @brief Decodes opcodes into timing and control signals
* @author Nicholas Amore namore7@gmail.com
* @date Creater 8/6/2025
*/

`timescale 1ns/1ps

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

//ALU outputs
localparam ADD   = 3'b010;
localparam SUB   = 3'b110;
localparam AND   = 3'b000;
localparam OR    = 3'b001;
localparam SLT   = 3'b111;

//Selection Parameters
localparam NULL_SEL        = 8'b00000000;
localparam ALU_A_SEL       = 8'b00000001;
localparam ALU_B_SEL_01    = 8'b00000010;
localparam ALU_B_SEL_10    = 8'b00000100;
localparam PC_SEL_01       = 8'b00001000;
localparam PC_SEL_10       = 8'b00010000;
localparam MEM_SEL         = 8'b00100000;
localparam REG_WR_DAT_SEL  = 8'b01000000;
localparam REG_WR_ADDR_SEL = 8'b10000000;

//Enable Parameters
localparam NULL_EN   = 5'b00000;
localparam REG_F_EN  = 5'b00001;
localparam BRANCH_EN = 5'b00010;
localparam PC_EN     = 5'b00100;
localparam MEM_EN    = 5'b01000;
localparam IR_EN     = 5'b10000;

module control_unit (
  input         clk_i,
  input         rst_ni,

  input  [5:0]  opcode_i,
  input  [5:0]  funct_i,

  output        mem_addr_sel_o,
  output        mem_wr_en_o,

  output        ir_wr_en_o,

  output        reg_wr_en_o,
  output        reg_wr_addr_sel_o,
  output        reg_wr_dat_sel_o,

  output        alu_op_a_sel_o,
  output  [1:0] alu_op_b_sel_o,
  output  [2:0] alu_op_o,

  output  [1:0] pc_src_sel_o,
  output        cntl_branch_o,
  output        pc_wr_en_o
);

typedef enum {
  StFetch,
  StDecode,
  StMemAdr,
  StMemRead,
  StMemWriteback,
  StMemWrite,
  StExecute,
  StALUWriteback,
  StBranch,
  StADDIExecute,
  StADDIWriteback,
  StJump
} state_e;

state_e state_d, state_q;

logic [7:0] mux_sel;
logic [4:0] reg_en;
logic [1:0] alu_sel;

logic [2:0] alu_op;

assign reg_wr_addr_sel_o = mux_sel[7];
assign reg_wr_dat_sel_o  = mux_sel[6];
assign mem_addr_sel_o    = mux_sel[5];
assign pc_src_sel_o      = mux_sel[4:3];
assign alu_op_b_sel_o    = mux_sel[2:1];
assign alu_op_a_sel_o    = mux_sel[0];

assign ir_wr_en_o    = reg_en[4];
assign mem_wr_en_o   = reg_en[3];
assign pc_wr_en_o    = reg_en[2];
assign cntl_branch_o = reg_en[1];
assign reg_wr_en_o   = reg_en[0];

assign alu_op_o = alu_op;

always_ff @(posedge clk_i or negedge rst_ni) begin
  if (!rst_ni) begin
    state_q <= StFetch;
  end else begin
    state_q <= state_d;
  end
end

always_comb begin
  state_d = state_q;
  unique case (state_q)
    StFetch: begin //Retrieves instruction from memory
      mux_sel = ALU_B_SEL_01; //Sets memory to read address from PC, ALU to increment address of PC
      reg_en  = PC_EN | IR_EN; //Writes new address to PC, stores instruction in IR
      alu_sel = 2'b00; //Sets addition operation
      state_d = StDecode; //Move to interpret instruction
    end
    StDecode: begin //Interprets retrieved instruction
      mux_sel = ALU_B_SEL_01 | ALU_B_SEL_10;
      reg_en  = NULL_EN;
      alu_sel = 2'b00;
      unique case (opcode_i) //Next state determined by opcode
        OP_R: begin
          state_d = StExecute;
        end
        OP_J: begin
          state_d = StJump;
        end
        OP_BEQ: begin
          state_d = StBranch;
        end
        OP_ADDI: begin
          state_d = StADDIExecute;
        end
        OP_LDW: begin
          state_d = StMemAdr;
        end
        OP_STW: begin
          state_d = StMemAdr;
        end
        default: begin
          state_d = StFetch;
        end
      endcase
    end
    StMemAdr: begin //Computes location of memory address from instruction
      mux_sel = ALU_B_SEL_10 | ALU_A_SEL; //Sets ALU operands to output of register file and sign extended immediate.
      reg_en  = NULL_EN; //No register writes
      alu_sel = 2'b00; //Sets addition operation. Result stored in accumulator
      if (opcode_i == OP_LDW) begin
        state_d = StMemRead;
      end else if (opcode_i == OP_STW) begin
        state_d = StMemWrite;
      end else begin
        state_d = StFetch;
      end
    end
    StMemRead: begin
      mux_sel = MEM_SEL;
      reg_en  = NULL_EN;
      alu_sel = 2'b00;
      state_d = StMemWriteback;
    end
    StMemWriteback: begin
      mux_sel = REG_WR_DAT_SEL;
      reg_en  = REG_F_EN;
      alu_sel = 2'b00;
      state_d = StFetch;
    end
    StMemWrite: begin
      mux_sel = MEM_SEL;
      reg_en  = MEM_EN;
      alu_sel = 2'b00;
      state_d = StFetch;
    end
    StExecute: begin
      mux_sel = ALU_A_SEL;
      reg_en  = NULL_EN;
      alu_sel = 2'b10;
      state_d = StALUWriteback;
    end
    StALUWriteback: begin
      mux_sel = REG_WR_ADDR_SEL;
      reg_en  = REG_F_EN;
      alu_sel = 2'b00;
      state_d = StFetch;
    end
    StBranch: begin
      mux_sel = PC_SEL_01 | ALU_A_SEL;
      reg_en  = BRANCH_EN;
      alu_sel = 2'b01;
      state_d = StFetch;
    end
    StADDIExecute: begin
      mux_sel = ALU_B_SEL_10 | ALU_A_SEL;
      reg_en  = NULL_EN;
      alu_sel = 2'b00;
      state_d = StADDIWriteback;
    end
    StADDIWriteback: begin
      mux_sel = NULL_SEL;
      reg_en  = REG_F_EN;
      alu_sel = 2'b00;
      state_d = StFetch;
    end
    StJump: begin
      mux_sel = PC_SEL_10;
      reg_en  = PC_EN;
      alu_sel = 2'b00;
      state_d = StFetch;
    end
    default: begin
      mux_sel = NULL_SEL;
      reg_en  = NULL_EN;
      alu_sel = 2'b00;
      state_d = StFetch;
    end
  endcase
end

always_comb begin
  unique case (alu_sel)
    2'b00: begin
      alu_op = ADD;
    end
    2'b01: begin
      alu_op = SUB;
    end
    2'b10: begin
      unique case (funct_i)
        R_ADD: begin
          alu_op = ADD;
        end
        R_SUB: begin
          alu_op = SUB;
        end
        R_AND: begin
          alu_op = AND;
        end
        R_OR: begin
          alu_op = OR;
        end
        R_SLT: begin
          alu_op = SLT;
        end
        default: begin
          alu_op = ADD;
        end
      endcase
    end
    default: begin
      alu_op = ADD;
    end
  endcase
end

endmodule