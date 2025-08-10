/*
* @file sev_seg_display.sv
* @brief Takes in hex number and outputs corresponding character for 7-segment display
* @author Nicholas Amore namore7@gmail.com
* @date Created 12/26/2022
*/

module sev_seg_display
(
  input logic [3:0]  dat_i,
  output logic [7:0] seven_seg_o
);

always_comb begin
  case(dat_i)
    4'h0: begin
      seven_seg_o = 8'hC0;
    end
    4'h1: begin
      seven_seg_o = 8'hF9;
    end
    4'h2: begin
      seven_seg_o = 8'hA4;
    end
    4'h3: begin
      seven_seg_o = 8'hB0;
    end
    4'h4: begin
      seven_seg_o = 8'h99;
    end
    4'h5: begin
      seven_seg_o = 8'h92;
    end
    4'h6: begin
      seven_seg_o = 8'h82;
    end
    4'h7: begin
      seven_seg_o = 8'hF8;
    end
    4'h8: begin
      seven_seg_o = 8'h80;
    end
    4'h9: begin
      seven_seg_o = 8'h90;
    end
    4'hA: begin
      seven_seg_o = 8'h88;
    end
    4'hB: begin
      seven_seg_o = 8'h83;
    end
    4'hC: begin
      seven_seg_o = 8'hC6;
    end
    4'hD: begin
      seven_seg_o = 8'hA1;
    end
    4'hE: begin
      seven_seg_o = 8'h86;
    end
    4'hF: begin
      seven_seg_o = 8'h87;
    end
    default: begin
      seven_seg_o = 8'hFF;
    end
  endcase
end
endmodule