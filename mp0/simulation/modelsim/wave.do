onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp0_tb/clk
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_resp
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_read
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_write
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_address
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_rdata
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_wdata
add wave -noupdate -expand -group forwarding_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding_inst/dest_mem
add wave -noupdate -expand -group forwarding_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding_inst/dest_wb
add wave -noupdate -expand -group forwarding_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding_inst/src1_ex
add wave -noupdate -expand -group forwarding_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding_inst/src2_ex
add wave -noupdate -expand -group forwarding_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding_inst/load_regfile_mem
add wave -noupdate -expand -group forwarding_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding_inst/load_regfile_wb
add wave -noupdate -expand -group forwarding_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding_inst/forward_a_sel
add wave -noupdate -expand -group forwarding_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding_inst/forward_b_sel
add wave -noupdate /mp0_tb/dut/cpu_inst/datapath/regfile_inst/src_a
add wave -noupdate /mp0_tb/dut/cpu_inst/datapath/regfile_inst/src_b
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/src1_data_out
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/src2_data_out
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/regfile_inst/reg_a
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/regfile_inst/reg_b
add wave -noupdate -radix hexadecimal -childformat {{{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} -radix decimal}} -expand -subitemconfig {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} {-height 15 -radix decimal}} /mp0_tb/dut/cpu_inst/datapath/regfile_inst/data
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/alu_inst/a
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/alu_inst/b
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/alu_inst/f
add wave -noupdate -expand -group forward_a -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_a/a
add wave -noupdate -expand -group forward_a -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_a/b
add wave -noupdate -expand -group forward_a -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_a/c
add wave -noupdate -expand -group forward_a -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_a/d
add wave -noupdate -expand -group forward_a -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_a/f
add wave -noupdate -expand -group forward_b -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_b/a
add wave -noupdate -expand -group forward_b -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_b/b
add wave -noupdate -expand -group forward_b -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_b/c
add wave -noupdate -expand -group forward_b -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_b/d
add wave -noupdate -expand -group forward_b -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_b/f
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/d_mem_rdata
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdr_WB_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {650352 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 359
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
WaveRestoreZoom {533750 ps} {796250 ps}
