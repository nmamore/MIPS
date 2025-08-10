onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group General -radix hexadecimal /tb_MIPS_top/uut/clk_i
add wave -noupdate -group General -radix hexadecimal /tb_MIPS_top/uut/mclk
add wave -noupdate -group General -radix hexadecimal /tb_MIPS_top/uut/clk_btn_ni
add wave -noupdate -group General -radix hexadecimal /tb_MIPS_top/uut/sync_clk_btn_n
add wave -noupdate -group General -radix hexadecimal /tb_MIPS_top/uut/rst_ni
add wave -noupdate -group General -radix hexadecimal /tb_MIPS_top/uut/sync_rst_n
add wave -noupdate -group General -radix hexadecimal /tb_MIPS_top/uut/sign_imm
add wave -noupdate -group SEV_SEG -radix hexadecimal /tb_MIPS_top/uut/hex_0_o
add wave -noupdate -group SEV_SEG -radix hexadecimal /tb_MIPS_top/uut/hex_1_o
add wave -noupdate -group SEV_SEG -radix hexadecimal /tb_MIPS_top/uut/hex_2_o
add wave -noupdate -group SEV_SEG -radix hexadecimal /tb_MIPS_top/uut/hex_3_o
add wave -noupdate -group SEV_SEG -radix hexadecimal /tb_MIPS_top/uut/hex_4_o
add wave -noupdate -group SEV_SEG -radix hexadecimal /tb_MIPS_top/uut/hex_5_o
add wave -noupdate -group SEV_SEG -radix hexadecimal /tb_MIPS_top/uut/disp_addr
add wave -noupdate -group SEV_SEG -radix hexadecimal /tb_MIPS_top/uut/disp_dat
add wave -noupdate -group SEV_SEG -radix hexadecimal /tb_MIPS_top/uut/ram_dat
add wave -noupdate -group LED -radix hexadecimal /tb_MIPS_top/uut/led_r_0_o
add wave -noupdate -group LED -radix hexadecimal /tb_MIPS_top/uut/led_r_1_o
add wave -noupdate -group LED -radix hexadecimal /tb_MIPS_top/uut/led_r_2_o
add wave -noupdate -group LED -radix hexadecimal /tb_MIPS_top/uut/led_r_3_o
add wave -noupdate -group LED -radix hexadecimal /tb_MIPS_top/uut/led_r_4_o
add wave -noupdate -group LED -radix hexadecimal /tb_MIPS_top/uut/led_r_5_o
add wave -noupdate -group LED -radix hexadecimal /tb_MIPS_top/uut/led_r_6_o
add wave -noupdate -group LED -radix hexadecimal /tb_MIPS_top/uut/led_r_7_o
add wave -noupdate -group LED -radix hexadecimal /tb_MIPS_top/uut/led_r_8_o
add wave -noupdate -group LED -radix hexadecimal /tb_MIPS_top/uut/led_r_9_o
add wave -noupdate -group LED -radix hexadecimal /tb_MIPS_top/uut/led_array
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sync_sw_0
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sync_sw_1
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sync_sw_2
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sync_sw_3
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sync_sw_4
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sync_sw_5
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sync_sw_6
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sync_sw_7
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sync_sw_8
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sync_sw_9
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sw_array
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/clk_sel
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/nibble_sel
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sw_0_i
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sw_1_i
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sw_2_i
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sw_3_i
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sw_4_i
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sw_5_i
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sw_6_i
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sw_7_i
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sw_8_i
add wave -noupdate -group Switches -radix hexadecimal /tb_MIPS_top/uut/sw_9_i
add wave -noupdate -group PC -radix hexadecimal /tb_MIPS_top/uut/pc_next
add wave -noupdate -group PC -radix hexadecimal /tb_MIPS_top/uut/pc_shift
add wave -noupdate -group PC -radix hexadecimal /tb_MIPS_top/uut/pc_branch
add wave -noupdate -group PC -radix hexadecimal /tb_MIPS_top/uut/pc_jta
add wave -noupdate -group PC -radix hexadecimal /tb_MIPS_top/uut/pc/clk_i
add wave -noupdate -group PC -radix hexadecimal /tb_MIPS_top/uut/pc/rst_ni
add wave -noupdate -group PC -radix hexadecimal /tb_MIPS_top/uut/pc/pc_next_i
add wave -noupdate -group PC -radix hexadecimal /tb_MIPS_top/uut/pc/pc_current_o
add wave -noupdate -group PC -radix hexadecimal /tb_MIPS_top/uut/pc/data_d
add wave -noupdate -group PC -radix hexadecimal /tb_MIPS_top/uut/pc/data_q
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/opcode_i
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/funct_i
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/alu_op_o
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/reg_wr_en_o
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/dat_mem_wr_en_o
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/reg_wr_addr_src_o
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/reg_wr_data_src_o
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/alu_operand_b_src_o
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/branch_o
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/jump_o
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/alu_op
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/op_val
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/funct_val
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/reg_wr_en
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/dat_mem_wr_en
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/reg_wr_addr_src
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/reg_wr_data_src
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/alu_operand_b_src
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/branch
add wave -noupdate -group Control -radix hexadecimal /tb_MIPS_top/uut/control/jump
add wave -noupdate -group INST_MEM -radix hexadecimal /tb_MIPS_top/uut/inst_mem/inst_mem_addr_i
add wave -noupdate -group INST_MEM -radix hexadecimal /tb_MIPS_top/uut/inst_mem/inst_mem_data_o
add wave -noupdate -group INST_MEM -radix hexadecimal /tb_MIPS_top/uut/inst_mem/addr
add wave -noupdate -group {Register File} -radix hexadecimal /tb_MIPS_top/uut/reg_file/clk_i
add wave -noupdate -group {Register File} -radix hexadecimal /tb_MIPS_top/uut/reg_file/rst_ni
add wave -noupdate -group {Register File} -radix hexadecimal /tb_MIPS_top/uut/reg_file/rd_addr_1_i
add wave -noupdate -group {Register File} -radix hexadecimal /tb_MIPS_top/uut/reg_file/rd_dat_1_o
add wave -noupdate -group {Register File} -radix hexadecimal /tb_MIPS_top/uut/reg_file/rd_addr_2_i
add wave -noupdate -group {Register File} -radix hexadecimal /tb_MIPS_top/uut/reg_file/rd_dat_2_o
add wave -noupdate -group {Register File} -radix hexadecimal /tb_MIPS_top/uut/reg_file/wr_en_i
add wave -noupdate -group {Register File} -radix hexadecimal /tb_MIPS_top/uut/reg_file/wr_addr_i
add wave -noupdate -group {Register File} -radix hexadecimal /tb_MIPS_top/uut/reg_file/wr_data_i
add wave -noupdate -group {Register File} -radix hexadecimal /tb_MIPS_top/uut/reg_file/reg_addr_1
add wave -noupdate -group {Register File} -radix hexadecimal /tb_MIPS_top/uut/reg_file/reg_addr_2
add wave -noupdate -group {Register File} -radix hexadecimal /tb_MIPS_top/uut/reg_file/wr_addr
add wave -noupdate -group {Register File} -radix hexadecimal /tb_MIPS_top/uut/reg_file/wr_data
add wave -noupdate -group {Register File} -radix hexadecimal /tb_MIPS_top/uut/reg_file/wr_en
add wave -noupdate -group ALU -radix hexadecimal /tb_MIPS_top/uut/alu/opcode_i
add wave -noupdate -group ALU -radix hexadecimal /tb_MIPS_top/uut/alu/operand_a_i
add wave -noupdate -group ALU -radix hexadecimal /tb_MIPS_top/uut/alu/operand_b_i
add wave -noupdate -group ALU -radix hexadecimal /tb_MIPS_top/uut/alu/zero_flag_o
add wave -noupdate -group ALU -radix hexadecimal /tb_MIPS_top/uut/alu/result_o
add wave -noupdate -group ALU -radix hexadecimal /tb_MIPS_top/uut/alu/operand_a
add wave -noupdate -group ALU -radix hexadecimal /tb_MIPS_top/uut/alu/operand_b
add wave -noupdate -group ALU -radix hexadecimal /tb_MIPS_top/uut/alu/alu_out
add wave -noupdate -group ALU -radix hexadecimal /tb_MIPS_top/uut/alu/temp
add wave -noupdate -group ALU -radix hexadecimal /tb_MIPS_top/uut/alu/op_val
add wave -noupdate -group {DAT MEM} -radix hexadecimal /tb_MIPS_top/uut/data_mem/clk_i
add wave -noupdate -group {DAT MEM} -radix hexadecimal /tb_MIPS_top/uut/data_mem/rst_ni
add wave -noupdate -group {DAT MEM} -radix hexadecimal /tb_MIPS_top/uut/data_mem/data_address_i
add wave -noupdate -group {DAT MEM} -radix hexadecimal /tb_MIPS_top/uut/data_mem/address_data_o
add wave -noupdate -group {DAT MEM} -radix hexadecimal /tb_MIPS_top/uut/data_mem/wr_en_i
add wave -noupdate -group {DAT MEM} -radix hexadecimal /tb_MIPS_top/uut/data_mem/wr_dat_i
add wave -noupdate -group {DAT MEM} -radix hexadecimal /tb_MIPS_top/uut/data_mem/disp_addr_i
add wave -noupdate -group {DAT MEM} -radix hexadecimal /tb_MIPS_top/uut/data_mem/disp_dat_o
add wave -noupdate -group {DAT MEM} -radix hexadecimal /tb_MIPS_top/uut/data_mem/addr
add wave -noupdate -group {DAT MEM} -radix hexadecimal /tb_MIPS_top/uut/data_mem/wr_dat
add wave -noupdate -group {DAT MEM} -radix hexadecimal /tb_MIPS_top/uut/data_mem/disp_addr
add wave -noupdate -group {DAT MEM} -radix hexadecimal /tb_MIPS_top/uut/data_mem/wr_en
add wave -noupdate -expand -group Memory -radix hexadecimal /tb_MIPS_top/uut/data_mem/ram_d
add wave -noupdate -expand -group Memory -radix hexadecimal /tb_MIPS_top/uut/reg_file/reg_data_d
add wave -noupdate -expand -group Memory -radix hexadecimal /tb_MIPS_top/uut/inst_mem/rom
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {43439 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 203
configure wave -valuecolwidth 63
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {2527738 ps}
