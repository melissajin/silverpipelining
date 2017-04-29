onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group predictor -radix hexadecimal /mp0_tb/dut/prefetcher/pf_predictor/clk
add wave -noupdate -expand -group predictor -radix hexadecimal /mp0_tb/dut/prefetcher/pf_predictor/hit
add wave -noupdate -expand -group predictor -radix hexadecimal /mp0_tb/dut/prefetcher/pf_predictor/prediction
add wave -noupdate -expand -group predictor -radix hexadecimal /mp0_tb/dut/prefetcher/pf_predictor/state
add wave -noupdate -expand -group control -radix hexadecimal /mp0_tb/dut/prefetcher/controller/prefetch_addr
add wave -noupdate -expand -group control -radix hexadecimal /mp0_tb/dut/prefetcher/controller/valid
add wave -noupdate -expand -group control -radix hexadecimal /mp0_tb/dut/prefetcher/controller/pf_prediction
add wave -noupdate -expand -group control -radix hexadecimal /mp0_tb/dut/prefetcher/controller/load_pf_line
add wave -noupdate -expand -group control -radix hexadecimal /mp0_tb/dut/prefetcher/controller/load_pf_addr
add wave -noupdate -expand -group control -radix hexadecimal /mp0_tb/dut/prefetcher/controller/i_rdata_sel
add wave -noupdate -expand -group control -radix hexadecimal /mp0_tb/dut/prefetcher/controller/l2_address_sel
add wave -noupdate -expand -group control -radix hexadecimal /mp0_tb/dut/prefetcher/controller/pf_hit
add wave -noupdate -expand -group control -radix hexadecimal /mp0_tb/dut/prefetcher/controller/i_read
add wave -noupdate -expand -group control -radix hexadecimal /mp0_tb/dut/prefetcher/controller/i_address
add wave -noupdate -expand -group control -radix hexadecimal /mp0_tb/dut/prefetcher/controller/i_resp
add wave -noupdate -expand -group control -radix hexadecimal /mp0_tb/dut/prefetcher/controller/l2_resp
add wave -noupdate -expand -group control -radix hexadecimal /mp0_tb/dut/prefetcher/controller/l2_read
add wave -noupdate -expand -group control -radix hexadecimal /mp0_tb/dut/prefetcher/controller/state
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/load_pf_line
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/load_pf_addr
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/i_rdata_sel
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/l2_address_sel
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/pf_hit
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/pf_prediction
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/prefetch_addr_out
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/valid
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/new_line
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/i_address
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/i_rdata
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/l2_rdata
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/l2_read
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/l2_address
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/prefetch_addr_in
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/clear_new
add wave -noupdate -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/datapath/prefetch_line_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {86845000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
configure wave -timelineunits ns
update
WaveRestoreZoom {76027703 ps} {97662297 ps}
