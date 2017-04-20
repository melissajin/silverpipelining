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
add wave -noupdate -radix hexadecimal /mp0_tb/dut/d_cache/control/eviction
add wave -noupdate -radix hexadecimal /mp0_tb/dut/d_cache/control/state
add wave -noupdate -radix hexadecimal /mp0_tb/dut/l2_inst/control/state
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/cw.wb
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_3
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_4
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_5
add wave -noupdate -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pc_out
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/mem_read
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/mem_write
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/mem_byte_enable
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/mem_address
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/mem_wdata
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/mem_resp
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/mem_rdata
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/l2_resp
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/l2_rdata
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/l2_read
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/l2_write
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/eviction
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/control/state
add wave -noupdate -expand -group i_to_arbit -expand -group i_addr_for_l2 -radix hexadecimal /mp0_tb/dut/i_cache/datapath/l2addr_mux/sel
add wave -noupdate -expand -group i_to_arbit -expand -group i_addr_for_l2 -radix hexadecimal /mp0_tb/dut/i_cache/datapath/l2addr_mux/a
add wave -noupdate -expand -group i_to_arbit -expand -group i_addr_for_l2 -radix hexadecimal /mp0_tb/dut/i_cache/datapath/l2addr_mux/b
add wave -noupdate -expand -group i_to_arbit -expand -group i_addr_for_l2 -radix hexadecimal /mp0_tb/dut/i_cache/datapath/l2addr_mux/c
add wave -noupdate -expand -group i_to_arbit -expand -group i_addr_for_l2 -radix hexadecimal /mp0_tb/dut/i_cache/datapath/l2addr_mux/d
add wave -noupdate -expand -group i_to_arbit -expand -group i_addr_for_l2 -radix hexadecimal /mp0_tb/dut/i_cache/datapath/l2addr_mux/f
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/l2_address
add wave -noupdate -expand -group i_to_arbit -radix hexadecimal /mp0_tb/dut/i_cache/l2_wdata
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
add wave -noupdate -radix hexadecimal -childformat {{{/mp0_tb/dut/i_cache/datapath/way0/tag/data[7]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[6]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[5]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[4]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[3]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[2]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[1]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[0]} -radix hexadecimal}} -subitemconfig {{/mp0_tb/dut/i_cache/datapath/way0/tag/data[7]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/way0/tag/data[6]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/way0/tag/data[5]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/way0/tag/data[4]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/way0/tag/data[3]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/way0/tag/data[2]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/way0/tag/data[1]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/way0/tag/data[0]} {-height 14 -radix hexadecimal}} /mp0_tb/dut/i_cache/datapath/way0/tag/data
add wave -noupdate -radix hexadecimal -childformat {{{/mp0_tb/dut/i_cache/datapath/lru/data[7]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/lru/data[6]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/lru/data[5]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/lru/data[4]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/lru/data[3]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/lru/data[2]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/lru/data[1]} -radix hexadecimal} {{/mp0_tb/dut/i_cache/datapath/lru/data[0]} -radix hexadecimal}} -subitemconfig {{/mp0_tb/dut/i_cache/datapath/lru/data[7]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/lru/data[6]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/lru/data[5]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/lru/data[4]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/lru/data[3]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/lru/data[2]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/lru/data[1]} {-height 14 -radix hexadecimal} {/mp0_tb/dut/i_cache/datapath/lru/data[0]} {-height 14 -radix hexadecimal}} /mp0_tb/dut/i_cache/datapath/lru/data
add wave -noupdate -radix hexadecimal /mp0_tb/dut/i_cache/datapath/way1/tag/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16657039 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 235
configure wave -valuecolwidth 202
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
WaveRestoreZoom {0 ps} {47869565 ps}
