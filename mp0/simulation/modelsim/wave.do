onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp0_tb/clk
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_resp
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_read
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_write
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_address
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_rdata
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_wdata
add wave -noupdate -radix hexadecimal -childformat {{{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} {-height 15 -radix hexadecimal}} /mp0_tb/dut/cpu_inst/datapath/regfile_inst/data
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pc_out
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pcbak_out
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/cw.wb
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_3
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_4
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_5
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/load
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/load_pc
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/load_pcbak
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/i_mem_resp
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_resp
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_read
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_write
add wave -noupdate -radix hexadecimal /mp0_tb/dut/i_cache/control/state
add wave -noupdate -radix hexadecimal /mp0_tb/dut/arbiter_inst/judge/state
add wave -noupdate -radix hexadecimal /mp0_tb/dut/arbiter_inst/judge/i_cache_read_in
add wave -noupdate -radix hexadecimal /mp0_tb/dut/arbiter_inst/judge/d_cache_read_in
add wave -noupdate -radix hexadecimal /mp0_tb/dut/arbiter_inst/judge/i_cache_write_in
add wave -noupdate -radix hexadecimal /mp0_tb/dut/arbiter_inst/judge/d_cache_write_in
add wave -noupdate -radix hexadecimal /mp0_tb/dut/arbiter_inst/judge/l2_resp_in
add wave -noupdate -radix hexadecimal /mp0_tb/dut/arbiter_inst/judge/cache_arbiter_sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1485868 ps} 0}
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
WaveRestoreZoom {1264426 ps} {1899868 ps}
