onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp0_tb/clk
add wave -noupdate -color Magenta -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/i_mem_resp
add wave -noupdate -color Magenta -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_resp
add wave -noupdate -color Magenta -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_read
add wave -noupdate -color Magenta -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_write
add wave -noupdate -color Orange -radix hexadecimal -childformat {{{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} {-color Orange -height 15 -radix hexadecimal}} /mp0_tb/dut/cpu_inst/datapath/regfile_inst/data
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pc_out
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/cw.wb
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_3
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_4
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_5
add wave -noupdate /mp0_tb/dut/cpu_inst/datapath/load
add wave -noupdate /mp0_tb/dut/cpu_inst/datapath/load_mem_wb
add wave -noupdate /mp0_tb/dut/cpu_inst/datapath/load_pc
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/sel
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/a
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/b
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/c
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/d
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/f
add wave -noupdate -color Cyan -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/sel
add wave -noupdate -color Cyan -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/a
add wave -noupdate -color Cyan -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/b
add wave -noupdate -color Cyan -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/c
add wave -noupdate -color Cyan -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/d
add wave -noupdate -color Cyan -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/f
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/alu_inst/aluop
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mar_MEM_out
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_WB_out
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_address
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_wdata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {619691 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 339
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
WaveRestoreZoom {598536 ps} {659838 ps}
