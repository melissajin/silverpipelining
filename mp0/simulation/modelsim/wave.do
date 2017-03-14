onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp0_tb/clk
add wave -noupdate -radix hexadecimal /mp0_tb/mem_resp
add wave -noupdate -radix hexadecimal /mp0_tb/mem_read
add wave -noupdate -radix hexadecimal /mp0_tb/mem_write
add wave -noupdate -radix hexadecimal /mp0_tb/mem_byte_enable
add wave -noupdate -radix hexadecimal /mp0_tb/mem_address
add wave -noupdate -radix hexadecimal /mp0_tb/mem_rdata
add wave -noupdate -radix hexadecimal /mp0_tb/mem_wdata
add wave -noupdate -radix hexadecimal /mp0_tb/clk
add wave -noupdate -radix hexadecimal /mp0_tb/mem_resp
add wave -noupdate -radix hexadecimal /mp0_tb/mem_read
add wave -noupdate -radix hexadecimal /mp0_tb/mem_write
add wave -noupdate -radix hexadecimal /mp0_tb/mem_byte_enable
add wave -noupdate -radix hexadecimal /mp0_tb/mem_address
add wave -noupdate -radix hexadecimal /mp0_tb/mem_rdata
add wave -noupdate -radix hexadecimal /mp0_tb/mem_wdata
add wave -noupdate -radix hexadecimal -childformat {{{/mp0_tb/dut/datapath/regfile_inst/data[7]} -radix hexadecimal} {{/mp0_tb/dut/datapath/regfile_inst/data[6]} -radix hexadecimal} {{/mp0_tb/dut/datapath/regfile_inst/data[5]} -radix hexadecimal} {{/mp0_tb/dut/datapath/regfile_inst/data[4]} -radix hexadecimal} {{/mp0_tb/dut/datapath/regfile_inst/data[3]} -radix hexadecimal} {{/mp0_tb/dut/datapath/regfile_inst/data[2]} -radix hexadecimal} {{/mp0_tb/dut/datapath/regfile_inst/data[1]} -radix hexadecimal} {{/mp0_tb/dut/datapath/regfile_inst/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp0_tb/dut/datapath/regfile_inst/data[7]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/datapath/regfile_inst/data[6]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/datapath/regfile_inst/data[5]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/datapath/regfile_inst/data[4]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/datapath/regfile_inst/data[3]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/datapath/regfile_inst/data[2]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/datapath/regfile_inst/data[1]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/datapath/regfile_inst/data[0]} {-height 15 -radix hexadecimal}} /mp0_tb/dut/datapath/regfile_inst/data
add wave -noupdate -radix hexadecimal /mp0_tb/dut/datapath/load
add wave -noupdate -radix hexadecimal -childformat {{/mp0_tb/dut/datapath/wb_sig_5.opcode -radix hexadecimal} {/mp0_tb/dut/datapath/wb_sig_5.destmux_sel -radix hexadecimal} {/mp0_tb/dut/datapath/wb_sig_5.mdrmux_WB_sel -radix hexadecimal} {/mp0_tb/dut/datapath/wb_sig_5.regfilemux_sel -radix hexadecimal} {/mp0_tb/dut/datapath/wb_sig_5.load_pipe_wb -radix hexadecimal} {/mp0_tb/dut/datapath/wb_sig_5.load_cc -radix hexadecimal} {/mp0_tb/dut/datapath/wb_sig_5.load_regfile -radix hexadecimal}} -subitemconfig {/mp0_tb/dut/datapath/wb_sig_5.opcode {-height 14 -radix hexadecimal} /mp0_tb/dut/datapath/wb_sig_5.destmux_sel {-height 14 -radix hexadecimal} /mp0_tb/dut/datapath/wb_sig_5.mdrmux_WB_sel {-height 14 -radix hexadecimal} /mp0_tb/dut/datapath/wb_sig_5.regfilemux_sel {-height 14 -radix hexadecimal} /mp0_tb/dut/datapath/wb_sig_5.load_pipe_wb {-height 14 -radix hexadecimal} /mp0_tb/dut/datapath/wb_sig_5.load_cc {-height 14 -radix hexadecimal} /mp0_tb/dut/datapath/wb_sig_5.load_regfile {-height 14 -radix hexadecimal}} /mp0_tb/dut/datapath/wb_sig_5
add wave -noupdate -radix hexadecimal /mp0_tb/dut/datapath/mem_sig_4
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1966866 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 244
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
WaveRestoreZoom {1966688 ps} {2001754 ps}
