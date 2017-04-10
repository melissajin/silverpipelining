onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp0_tb/clk
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_resp
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_read
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_write
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_address
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_rdata
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_wdata
add wave -noupdate -color Orange -radix hexadecimal -childformat {{{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} {-color Orange -height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} {-color Orange -height 15 -radix hexadecimal}} /mp0_tb/dut/cpu_inst/datapath/regfile_inst/data
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pc_out
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pcbak_out
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/cw.wb
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_3
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_4
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_5
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/load
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/load_pc
add wave -noupdate -color Orange -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/load_pcbak
add wave -noupdate -color Magenta -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/i_mem_resp
add wave -noupdate -color Magenta -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_resp
add wave -noupdate -color Magenta -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_read
add wave -noupdate -color Magenta -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_write
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_a_EX_sel
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_b_EX_sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {303474 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 305
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
WaveRestoreZoom {289714 ps} {411122 ps}
