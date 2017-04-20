onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_resp
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_read
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_write
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_address
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_rdata
add wave -noupdate -radix hexadecimal /mp0_tb/pmem_wdata
add wave -noupdate -expand -group {forwading unit} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX
add wave -noupdate -expand -group {forwading unit} -radix hexadecimal -childformat {{/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.load_regfile_wb -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.dest_wb -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.sourceR_mem -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.baseR_mem -radix hexadecimal}} -subitemconfig {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.load_regfile_wb {-height 14 -radix hexadecimal} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.dest_wb {-height 14 -radix hexadecimal} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.sourceR_mem {-height 14 -radix hexadecimal} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.baseR_mem {-height 14 -radix hexadecimal}} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM
add wave -noupdate -expand -group {forwading unit} -radix hexadecimal -childformat {{/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_save.load_regfile_wb -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_save.forward_val -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_save.dest_wb -radix hexadecimal}} -subitemconfig {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_save.load_regfile_wb {-height 14 -radix hexadecimal} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_save.forward_val {-height 14 -radix hexadecimal} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_save.dest_wb {-height 14 -radix hexadecimal}} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_save
add wave -noupdate -expand -group {forwading unit} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/indirectmux_sel
add wave -noupdate -expand -group {forwading unit} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/address_MEM
add wave -noupdate -expand -group {forwading unit} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/address_WB
add wave -noupdate -expand -group {forwading unit} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/d_mem_write_WB
add wave -noupdate -expand -group {forwading unit} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_a_EX_sel
add wave -noupdate -expand -group {forwading unit} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_b_EX_sel
add wave -noupdate -expand -group {forwading unit} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM_data_sel
add wave -noupdate -expand -group {forwading unit} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM_addr_sel
add wave -noupdate -expand -group {forwading unit} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/mdr_WB_in_mux_sel
add wave -noupdate -expand -group cpu -radix hexadecimal /mp0_tb/dut/cpu_inst/i_mem_resp
add wave -noupdate -expand -group cpu -radix hexadecimal /mp0_tb/dut/cpu_inst/i_mem_rdata
add wave -noupdate -expand -group cpu -radix hexadecimal /mp0_tb/dut/cpu_inst/i_mem_read
add wave -noupdate -expand -group cpu -radix hexadecimal /mp0_tb/dut/cpu_inst/i_mem_address
add wave -noupdate -expand -group cpu -radix hexadecimal /mp0_tb/dut/cpu_inst/d_mem_resp
add wave -noupdate -expand -group cpu -radix hexadecimal /mp0_tb/dut/cpu_inst/d_mem_rdata
add wave -noupdate -expand -group cpu -radix hexadecimal /mp0_tb/dut/cpu_inst/d_mem_read
add wave -noupdate -expand -group cpu -radix hexadecimal /mp0_tb/dut/cpu_inst/d_mem_write
add wave -noupdate -expand -group cpu -radix hexadecimal /mp0_tb/dut/cpu_inst/d_mem_byte_enable
add wave -noupdate -expand -group cpu -radix hexadecimal /mp0_tb/dut/cpu_inst/d_mem_address
add wave -noupdate -expand -group cpu -radix hexadecimal /mp0_tb/dut/cpu_inst/d_mem_wdata
add wave -noupdate -expand -group cpu -radix hexadecimal -childformat {{{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} -radix hexadecimal}} -subitemconfig {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} {-height 15 -radix hexadecimal}} /mp0_tb/dut/cpu_inst/datapath/regfile_inst/data
add wave -noupdate -expand -group cpu -expand -group {d_mem_data_mux } -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/sel
add wave -noupdate -expand -group cpu -expand -group {d_mem_data_mux } -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/a
add wave -noupdate -expand -group cpu -expand -group {d_mem_data_mux } -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/b
add wave -noupdate -expand -group cpu -expand -group {d_mem_data_mux } -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/c
add wave -noupdate -expand -group cpu -expand -group {d_mem_data_mux } -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/d
add wave -noupdate -expand -group cpu -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/f
add wave -noupdate -expand -group cpu -expand -group opcodes -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/cw.wb
add wave -noupdate -expand -group cpu -expand -group opcodes -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_3
add wave -noupdate -expand -group cpu -expand -group opcodes -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_4
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_5
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pc_out
add wave -noupdate -radix hexadecimal -childformat {{{/mp0_tb/dut/i_cache/datapath/way0/tag/data[7]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[6]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[5]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[4]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[3]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[2]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[1]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[0]} -radix hexadecimal}} -subitemconfig {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[7]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/way0/tag/data[6]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/way0/tag/data[5]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/way0/tag/data[4]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/way0/tag/data[3]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/way0/tag/data[2]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/way0/tag/data[1]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/way0/tag/data[0]} {-height 14 -radix hexadecimal}} /mp0_tb/dut/i_cache/datapath/way0/tag/data
add wave -noupdate -radix hexadecimal -childformat {{{/mp0_tb/dut/i_cache/datapath/lru/data[7]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/lru/data[6]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/lru/data[5]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/lru/data[4]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/lru/data[3]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/lru/data[2]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/lru/data[1]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/lru/data[0]} -radix hexadecimal}} -subitemconfig {{/mp0_tb/dut/i_cache/datapath/lru/data[7]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/lru/data[6]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/lru/data[5]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/lru/data[4]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/lru/data[3]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/lru/data[2]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/lru/data[1]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/lru/data[0]} {-height 14 -radix hexadecimal}} /mp0_tb/dut/i_cache/datapath/lru/data
add wave -noupdate -radix hexadecimal /mp0_tb/dut/i_cache/datapath/way1/tag/data
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/mem_read
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/mem_write
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/mem_byte_enable
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/mem_address
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/mem_wdata
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/mem_resp
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/mem_rdata
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/l2_resp
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/l2_rdata
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/l2_read
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/l2_write
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/eviction
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/control/state
add wave -noupdate -group i_to_arbit -expand -group i_addr_for_l2 -radix hexadecimal /mp0_tb/dut/i_cache/datapath/l2addr_mux/sel
add wave -noupdate -group i_to_arbit -expand -group i_addr_for_l2 -radix hexadecimal /mp0_tb/dut/i_cache/datapath/l2addr_mux/a
add wave -noupdate -group i_to_arbit -expand -group i_addr_for_l2 -radix hexadecimal /mp0_tb/dut/i_cache/datapath/l2addr_mux/b
add wave -noupdate -group i_to_arbit -expand -group i_addr_for_l2 -radix hexadecimal /mp0_tb/dut/i_cache/datapath/l2addr_mux/c
add wave -noupdate -group i_to_arbit -expand -group i_addr_for_l2 -radix hexadecimal /mp0_tb/dut/i_cache/datapath/l2addr_mux/d
add wave -noupdate -group i_to_arbit -expand -group i_addr_for_l2 -radix hexadecimal /mp0_tb/dut/i_cache/datapath/l2addr_mux/f
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/l2_address
add wave -noupdate -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/l2_wdata
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/clk
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/i_cache_address_in
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/d_cache_address_in
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/i_cache_wdata_in
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/d_cache_wdata_in
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/i_cache_read_in
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/d_cache_read_in
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/i_cache_write_in
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/d_cache_write_in
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/d_cache_resp_out
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/i_cache_resp_out
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/d_cache_rdata_out
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/i_cache_rdata_out
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/l2_rdata_in
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/l2_resp_in
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/l2_address_out
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/l2_wdata_out
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/l2_read_out
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/l2_write_out
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/cache_arbiter_sel
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/i_cache_wdata_in_sync
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/d_cache_wdata_in_sync
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/i_cache_read_in_sync
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/d_cache_read_in_sync
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/i_cache_write_in_sync
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/d_cache_write_in_sync
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/i_cache_address_in_sync
add wave -noupdate -group arbiter -radix hexadecimal /mp0_tb/dut/arbiter_inst/d_cache_address_in_sync
add wave -noupdate -group i_and_d_mem_stuff -radix hexadecimal /mp0_tb/dut/cpu_inst/i_mem_resp
add wave -noupdate -group i_and_d_mem_stuff -radix hexadecimal /mp0_tb/dut/cpu_inst/i_mem_rdata
add wave -noupdate -group i_and_d_mem_stuff -radix hexadecimal /mp0_tb/dut/cpu_inst/i_mem_read
add wave -noupdate -group i_and_d_mem_stuff -radix hexadecimal /mp0_tb/dut/cpu_inst/i_mem_address
add wave -noupdate -group i_and_d_mem_stuff -radix hexadecimal /mp0_tb/dut/cpu_inst/d_mem_resp
add wave -noupdate -group i_and_d_mem_stuff -radix hexadecimal /mp0_tb/dut/cpu_inst/d_mem_rdata
add wave -noupdate -group i_and_d_mem_stuff -radix hexadecimal /mp0_tb/dut/cpu_inst/d_mem_read
add wave -noupdate -group i_and_d_mem_stuff -radix hexadecimal /mp0_tb/dut/cpu_inst/d_mem_write
add wave -noupdate -group i_and_d_mem_stuff -radix hexadecimal /mp0_tb/dut/cpu_inst/d_mem_byte_enable
add wave -noupdate -group i_and_d_mem_stuff -radix hexadecimal /mp0_tb/dut/cpu_inst/d_mem_address
add wave -noupdate -group i_and_d_mem_stuff -radix hexadecimal /mp0_tb/dut/cpu_inst/d_mem_wdata
add wave -noupdate -group frd_sr1_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/sel
add wave -noupdate -group frd_sr1_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/a
add wave -noupdate -group frd_sr1_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/b
add wave -noupdate -group frd_sr1_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/c
add wave -noupdate -group frd_sr1_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/d
add wave -noupdate -group frd_sr1_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/f
add wave -noupdate -radix hexadecimal /mp0_tb/clk
add wave -noupdate -expand -group frd_sr2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/sel
add wave -noupdate -expand -group frd_sr2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/a
add wave -noupdate -expand -group frd_sr2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/b
add wave -noupdate -expand -group frd_sr2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/c
add wave -noupdate -expand -group frd_sr2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/d
add wave -noupdate -expand -group frd_sr2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/f
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18208703 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 298
configure wave -valuecolwidth 202
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
WaveRestoreZoom {18176226 ps} {18248386 ps}
