onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp0_tb/clk
add wave -noupdate -color Orange -radix hexadecimal -childformat {{{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} {-color Orange -height 15 -radix hexadecimal}} /mp0_tb/dut/cpu_inst/datapath/regfile_inst/data
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/wdata_forward_in
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/wdata_forward_out
add wave -noupdate -color {Slate Blue} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdr_wb_in_mux/a
add wave -noupdate -color {Slate Blue} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdr_wb_in_mux/b
add wave -noupdate -color {Slate Blue} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdr_wb_in_mux/f
add wave -noupdate -color {Slate Blue} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdr_wb_in_mux/sel
add wave -noupdate -expand -group meme_signals -color {Sky Blue} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/i_mem_resp
add wave -noupdate -expand -group meme_signals -color {Sky Blue} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/i_mem_read
add wave -noupdate -expand -group meme_signals -color {Sky Blue} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/i_mem_rdata
add wave -noupdate -expand -group meme_signals -color {Sky Blue} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/i_mem_address
add wave -noupdate -expand -group meme_signals -color {Sky Blue} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_resp
add wave -noupdate -expand -group meme_signals -color {Sky Blue} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_read
add wave -noupdate -expand -group meme_signals -color {Sky Blue} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_write
add wave -noupdate -expand -group meme_signals -color {Sky Blue} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_rdata
add wave -noupdate -expand -group meme_signals -color {Sky Blue} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_address
add wave -noupdate -expand -group meme_signals -color {Sky Blue} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_wdata
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pc/out
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/cw.wb
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_3
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_4
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_5
add wave -noupdate -expand -group dest-nzp -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/nzp_ID
add wave -noupdate -expand -group dest-nzp -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/nzp_EX
add wave -noupdate -expand -group dest-nzp -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/nzp_MEM
add wave -noupdate -expand -group dest-nzp -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/nzp_WB
add wave -noupdate -group d_mem_address_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_address_mux/sel
add wave -noupdate -group d_mem_address_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_address_mux/a
add wave -noupdate -group d_mem_address_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_address_mux/b
add wave -noupdate -group d_mem_address_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_address_mux/c
add wave -noupdate -group d_mem_address_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_address_mux/d
add wave -noupdate -group d_mem_address_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_address_mux/f
add wave -noupdate -expand -group alu -color Magenta -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/alu_inst/aluop
add wave -noupdate -expand -group alu -color Magenta -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/alu_inst/a
add wave -noupdate -expand -group alu -color Magenta -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/alu_inst/b
add wave -noupdate -expand -group alu -color Magenta -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/alu_inst/f
add wave -noupdate -group d_mem_data_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/sel
add wave -noupdate -group d_mem_data_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/a
add wave -noupdate -group d_mem_data_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/b
add wave -noupdate -group d_mem_data_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/c
add wave -noupdate -group d_mem_data_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/d
add wave -noupdate -group d_mem_data_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/f
add wave -noupdate -group forward_sr1 -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/sel
add wave -noupdate -group forward_sr1 -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/a
add wave -noupdate -group forward_sr1 -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/b
add wave -noupdate -group forward_sr1 -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/c
add wave -noupdate -group forward_sr1 -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/d
add wave -noupdate -group forward_sr1 -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/f
add wave -noupdate -group forward_src2 -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/sel
add wave -noupdate -group forward_src2 -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/a
add wave -noupdate -group forward_src2 -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/b
add wave -noupdate -group forward_src2 -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/c
add wave -noupdate -group forward_src2 -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/d
add wave -noupdate -group forward_src2 -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/f
add wave -noupdate -group mdr_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_ex/sel
add wave -noupdate -group mdr_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_ex/a
add wave -noupdate -group mdr_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_ex/b
add wave -noupdate -group mdr_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_ex/c
add wave -noupdate -group mdr_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_ex/d
add wave -noupdate -group mdr_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_ex/f
add wave -noupdate -group regfile_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/regfilemux/sel
add wave -noupdate -group regfile_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/regfilemux/a
add wave -noupdate -group regfile_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/regfilemux/b
add wave -noupdate -group regfile_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/regfilemux/c
add wave -noupdate -group regfile_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/regfilemux/d
add wave -noupdate -group regfile_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/regfilemux/f
add wave -noupdate -group mdr_wb_in_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdr_wb_in_mux/sel
add wave -noupdate -group mdr_wb_in_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdr_wb_in_mux/a
add wave -noupdate -group mdr_wb_in_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdr_wb_in_mux/b
add wave -noupdate -group mdr_wb_in_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdr_wb_in_mux/f
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdr_MEM_out
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/mar_WB_in
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/mar_WB_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {670743 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 354
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {658730 ps} {761270 ps}
