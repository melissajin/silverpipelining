onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp0_tb/clk
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_resp
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_read
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_write
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_address
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_rdata
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_wdata
add wave -noupdate -radix hexadecimal -childformat {{{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} -radix hexadecimal}} -subitemconfig {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} {-radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} {-radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} {-radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} {-radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} {-radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} {-radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} {-radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} {-radix hexadecimal}} /mp0_tb/dut/cpu_inst/datapath/regfile_inst/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {1999050 ps} {2000050 ps}
