onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp0_tb/clk
add wave -noupdate -radix hexadecimal /mp0_tb/resp_a
add wave -noupdate -radix hexadecimal /mp0_tb/resp_b
add wave -noupdate -radix hexadecimal /mp0_tb/read_a
add wave -noupdate -radix hexadecimal /mp0_tb/read_b
add wave -noupdate -radix hexadecimal /mp0_tb/write_a
add wave -noupdate -radix hexadecimal /mp0_tb/write_b
add wave -noupdate -radix hexadecimal /mp0_tb/wmask_a
add wave -noupdate -radix hexadecimal /mp0_tb/wmask_b
add wave -noupdate -radix hexadecimal /mp0_tb/address_a
add wave -noupdate -radix hexadecimal /mp0_tb/address_b
add wave -noupdate -radix hexadecimal /mp0_tb/rdata_a
add wave -noupdate -radix hexadecimal /mp0_tb/rdata_b
add wave -noupdate -radix hexadecimal /mp0_tb/wdata_a
add wave -noupdate -radix hexadecimal /mp0_tb/wdata_b
add wave -noupdate -radix hexadecimal /mp0_tb/dut/datapath/regfile_inst/data
add wave -noupdate -radix hexadecimal /mp0_tb/dut/datapath/wb_sig_5
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {507143 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {2100 ns}

restart -f
run 2000ns
