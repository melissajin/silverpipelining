onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mp0_tb/clk
add wave -noupdate -expand -group PMEM -radix hexadecimal /mp0_tb/pmem_resp
add wave -noupdate -expand -group PMEM -radix hexadecimal /mp0_tb/pmem_read
add wave -noupdate -expand -group PMEM -radix hexadecimal /mp0_tb/pmem_write
add wave -noupdate -expand -group PMEM -radix hexadecimal /mp0_tb/pmem_address
add wave -noupdate -expand -group PMEM -radix hexadecimal /mp0_tb/pmem_rdata
add wave -noupdate -expand -group PMEM -radix hexadecimal /mp0_tb/pmem_wdata
add wave -noupdate -expand -group CPU -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/cw.wb.opcode
add wave -noupdate -expand -group CPU -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_3.opcode
add wave -noupdate -expand -group CPU -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_4.opcode
add wave -noupdate -expand -group CPU -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/wb_sig_5.opcode
add wave -noupdate -expand -group CPU -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/cccomp_inst/br_enable
add wave -noupdate -expand -group CPU -radix hexadecimal -childformat {{{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} -radix hexadecimal} {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} -radix hexadecimal}} -expand -subitemconfig {{/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[7]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[6]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[5]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[4]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[3]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[2]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[1]} {-height 15 -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/regfile_inst/data[0]} {-height 15 -radix hexadecimal}} /mp0_tb/dut/cpu_inst/datapath/regfile_inst/data
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/br_enable
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/i_mem_resp
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/d_mem_resp
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/d_mem_read
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/d_mem_write
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/MEM_inter_read
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/MEM_inter_write
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/op_IF
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/op_ID
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/op_EX
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/op_MEM
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/op_MEM_inter
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/op_WB
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/nzp_ID
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/nzp_EX
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/nzp_MEM
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/nzp_WB
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/load
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/load_pc
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/load_pcbak
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/control_instruc_ident_wb
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/i_mem_read
add wave -noupdate -expand -group CPU -group hazard_detection_unit -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/mem_op
add wave -noupdate -expand -group CPU /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/flush
add wave -noupdate -expand -group CPU -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/prediction
add wave -noupdate -expand -group CPU -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/br_instruction
add wave -noupdate -expand -group CPU -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/taken
add wave -noupdate -expand -group CPU -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/hazard_detection_inst/not_taken
add wave -noupdate -expand -group CPU -group forwarding -radix hexadecimal -childformat {{/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX.dest_mem -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX.dest_wb -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX.src1_ex -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX.src2_ex -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX.load_regfile_mem -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX.load_regfile_wb -radix hexadecimal}} -expand -subitemconfig {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX.dest_mem {-height 15 -radix hexadecimal} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX.dest_wb {-height 15 -radix hexadecimal} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX.src1_ex {-height 15 -radix hexadecimal} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX.src2_ex {-height 15 -radix hexadecimal} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX.load_regfile_mem {-height 15 -radix hexadecimal} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX.load_regfile_wb {-height 15 -radix hexadecimal}} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_EX
add wave -noupdate -expand -group CPU -group forwarding -radix hexadecimal -childformat {{/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.load_regfile_wb -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.dest_wb -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.sourceR_mem -radix hexadecimal} {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.baseR_mem -radix hexadecimal}} -expand -subitemconfig {/mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.load_regfile_wb {-height 15 -radix hexadecimal} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.dest_wb {-height 15 -radix hexadecimal} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.sourceR_mem {-height 15 -radix hexadecimal} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM.baseR_mem {-height 15 -radix hexadecimal}} /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM
add wave -noupdate -expand -group CPU -group forwarding -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_save
add wave -noupdate -expand -group CPU -group forwarding -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/indirectmux_sel
add wave -noupdate -expand -group CPU -group forwarding -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/address_MEM
add wave -noupdate -expand -group CPU -group forwarding -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/address_WB
add wave -noupdate -expand -group CPU -group forwarding -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/d_mem_write_WB
add wave -noupdate -expand -group CPU -group forwarding -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_a_EX_sel
add wave -noupdate -expand -group CPU -group forwarding -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_b_EX_sel
add wave -noupdate -expand -group CPU -group forwarding -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM_data_sel
add wave -noupdate -expand -group CPU -group forwarding -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forwarding/forward_MEM_addr_sel
add wave -noupdate -expand -group CPU -group pcmux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pcmux/sel
add wave -noupdate -expand -group CPU -group pcmux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pcmux/a
add wave -noupdate -expand -group CPU -group pcmux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pcmux/b
add wave -noupdate -expand -group CPU -group pcmux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pcmux/c
add wave -noupdate -expand -group CPU -group pcmux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pcmux/d
add wave -noupdate -expand -group CPU -group pcmux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pcmux/e
add wave -noupdate -expand -group CPU -group pcmux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pcmux/f
add wave -noupdate -expand -group CPU -group pcmux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pcmux/g
add wave -noupdate -expand -group CPU -group pcmux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pcmux/h
add wave -noupdate -expand -group CPU -group pcmux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pcmux/y
add wave -noupdate -expand -group CPU -group pc_reg -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pc/load
add wave -noupdate -expand -group CPU -group pc_reg -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pc/in
add wave -noupdate -expand -group CPU -group pc_reg -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pc/out
add wave -noupdate -expand -group CPU -group pc_reg -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pc/data
add wave -noupdate -expand -group CPU -group ir_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/irmux/sel
add wave -noupdate -expand -group CPU -group ir_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/irmux/a
add wave -noupdate -expand -group CPU -group ir_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/irmux/b
add wave -noupdate -expand -group CPU -group ir_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/irmux/f
add wave -noupdate -expand -group CPU -group IF_ID -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/IF_ID/load
add wave -noupdate -expand -group CPU -group IF_ID -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/IF_ID/pc_ID_in
add wave -noupdate -expand -group CPU -group IF_ID -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/IF_ID/ir_in
add wave -noupdate -expand -group CPU -group IF_ID -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/IF_ID/pc_ID_out
add wave -noupdate -expand -group CPU -group IF_ID -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/IF_ID/opcode
add wave -noupdate -expand -group CPU -group IF_ID -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/IF_ID/dest_ID_out
add wave -noupdate -expand -group CPU -group IF_ID -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/IF_ID/src1
add wave -noupdate -expand -group CPU -group IF_ID -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/IF_ID/src2
add wave -noupdate -expand -group CPU -group IF_ID -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/IF_ID/ir_10_0
add wave -noupdate -expand -group CPU -group dest_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/destmux/sel
add wave -noupdate -expand -group CPU -group dest_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/destmux/a
add wave -noupdate -expand -group CPU -group dest_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/destmux/b
add wave -noupdate -expand -group CPU -group dest_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/destmux/f
add wave -noupdate -expand -group CPU -group src2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/src2mux/sel
add wave -noupdate -expand -group CPU -group src2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/src2mux/a
add wave -noupdate -expand -group CPU -group src2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/src2mux/b
add wave -noupdate -expand -group CPU -group src2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/src2mux/f
add wave -noupdate -expand -group CPU -group reg_file_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/regfilemux/sel
add wave -noupdate -expand -group CPU -group reg_file_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/regfilemux/a
add wave -noupdate -expand -group CPU -group reg_file_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/regfilemux/b
add wave -noupdate -expand -group CPU -group reg_file_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/regfilemux/c
add wave -noupdate -expand -group CPU -group reg_file_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/regfilemux/d
add wave -noupdate -expand -group CPU -group reg_file_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/regfilemux/f
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/load
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/ex_sig_in
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/mem_sig_in
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/wb_sig_in
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/ex_sig_out
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/mem_sig_out
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/wb_sig_out
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/dest_EX_in
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/src1_EX_in
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/src2_EX_in
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/pc_EX_in
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/src1_data_in
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/src2_data_in
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/ir_10_0_in
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/dest_EX_out
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/src1_EX_out
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/src2_EX_out
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/pc_EX_out
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/src1_data_EX
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/src2_data_EX
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/imm4_EX
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/imm5_EX
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/offset6_EX
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/trapVect8_EX
add wave -noupdate -expand -group CPU -group ID_EX -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/ID_EX/offset11_EX_out
add wave -noupdate -expand -group CPU -group frw_sr1_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/sel
add wave -noupdate -expand -group CPU -group frw_sr1_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/a
add wave -noupdate -expand -group CPU -group frw_sr1_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/b
add wave -noupdate -expand -group CPU -group frw_sr1_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/c
add wave -noupdate -expand -group CPU -group frw_sr1_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/d
add wave -noupdate -expand -group CPU -group frw_sr1_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr1_mux/f
add wave -noupdate -expand -group CPU -group frw_sr2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/sel
add wave -noupdate -expand -group CPU -group frw_sr2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/a
add wave -noupdate -expand -group CPU -group frw_sr2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/b
add wave -noupdate -expand -group CPU -group frw_sr2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/c
add wave -noupdate -expand -group CPU -group frw_sr2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/d
add wave -noupdate -expand -group CPU -group frw_sr2_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_sr2_mux/f
add wave -noupdate -expand -group CPU -group alu -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/alu_inst/aluop
add wave -noupdate -expand -group CPU -group alu -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/alu_inst/a
add wave -noupdate -expand -group CPU -group alu -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/alu_inst/b
add wave -noupdate -expand -group CPU -group alu -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/alu_inst/f
add wave -noupdate -expand -group CPU -group mar_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/marmux_ex/sel
add wave -noupdate -expand -group CPU -group mar_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/marmux_ex/a
add wave -noupdate -expand -group CPU -group mar_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/marmux_ex/b
add wave -noupdate -expand -group CPU -group mar_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/marmux_ex/f
add wave -noupdate -expand -group CPU -group mdr_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_ex/sel
add wave -noupdate -expand -group CPU -group mdr_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_ex/a
add wave -noupdate -expand -group CPU -group mdr_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_ex/b
add wave -noupdate -expand -group CPU -group mdr_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_ex/c
add wave -noupdate -expand -group CPU -group mdr_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_ex/d
add wave -noupdate -expand -group CPU -group mdr_mux_ex -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_ex/f
add wave -noupdate -expand -group CPU -group adder_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/addrmux/sel
add wave -noupdate -expand -group CPU -group adder_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/addrmux/a
add wave -noupdate -expand -group CPU -group adder_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/addrmux/b
add wave -noupdate -expand -group CPU -group adder_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/addrmux/f
add wave -noupdate -expand -group CPU -group pc_plus_off_adder -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pc_plus_off_adder/a
add wave -noupdate -expand -group CPU -group pc_plus_off_adder -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pc_plus_off_adder/b
add wave -noupdate -expand -group CPU -group pc_plus_off_adder -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/pc_plus_off_adder/c
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/load
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/mem_sig_in
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/wb_sig_in
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/mem_sig_out
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/wb_sig_out
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/dest_MEM_in
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/src1_MEM_in
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/src2_MEM_in
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/pc_MEM_in
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/alu_MEM_in
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/pcp_off_MEM_in
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/mar_MEM_in
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/mdr_MEM_in
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/offset11_MEM_in
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/mem_byte_enable_in
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/dest_MEM_out
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/src1_MEM_out
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/src2_MEM_out
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/pc_MEM_out
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/alu_MEM_out
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/pcp_off_MEM_out
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/mar_MEM_out
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/mdr_MEM_out
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/offset11_MEM_out
add wave -noupdate -expand -group CPU -group EX_MEM -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/EX_MEM/mem_byte_enable_out
add wave -noupdate -expand -group CPU -group forward_mem_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_mem_mux/sel
add wave -noupdate -expand -group CPU -group forward_mem_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_mem_mux/a
add wave -noupdate -expand -group CPU -group forward_mem_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_mem_mux/b
add wave -noupdate -expand -group CPU -group forward_mem_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_mem_mux/c
add wave -noupdate -expand -group CPU -group forward_mem_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_mem_mux/d
add wave -noupdate -expand -group CPU -group forward_mem_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_mem_mux/f
add wave -noupdate -expand -group CPU -group dmem_data_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/sel
add wave -noupdate -expand -group CPU -group dmem_data_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/a
add wave -noupdate -expand -group CPU -group dmem_data_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/b
add wave -noupdate -expand -group CPU -group dmem_data_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/c
add wave -noupdate -expand -group CPU -group dmem_data_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/d
add wave -noupdate -expand -group CPU -group dmem_data_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_data_mux/f
add wave -noupdate -expand -group CPU -group dmem_address_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_address_mux/sel
add wave -noupdate -expand -group CPU -group dmem_address_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_address_mux/a
add wave -noupdate -expand -group CPU -group dmem_address_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_address_mux/b
add wave -noupdate -expand -group CPU -group dmem_address_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_address_mux/c
add wave -noupdate -expand -group CPU -group dmem_address_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_address_mux/d
add wave -noupdate -expand -group CPU -group dmem_address_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/dmem_address_mux/f
add wave -noupdate -expand -group CPU -group address_adder -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/address_adder/a
add wave -noupdate -expand -group CPU -group address_adder -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/address_adder/b
add wave -noupdate -expand -group CPU -group address_adder -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/address_adder/c
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/load
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/wb_sig_in
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/wb_sig_out
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/dest_WB_in
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/pc_WB_in
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/alu_WB_in
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/pcp_off_WB_in
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/mdr_WB_in
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/mar_WB_in
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/dest_WB_out
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/pc_WB_out
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/alu_WB_out
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/pcp_off_WB_out
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/mdr_WB_out
add wave -noupdate -expand -group CPU -group MEM_WB -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/MEM_WB/mar_WB_out
add wave -noupdate -expand -group CPU -group mdr_mux_wb -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_wb/sel
add wave -noupdate -expand -group CPU -group mdr_mux_wb -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_wb/a
add wave -noupdate -expand -group CPU -group mdr_mux_wb -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_wb/b
add wave -noupdate -expand -group CPU -group mdr_mux_wb -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_wb/c
add wave -noupdate -expand -group CPU -group mdr_mux_wb -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_wb/d
add wave -noupdate -expand -group CPU -group mdr_mux_wb -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/mdrmux_wb/f
add wave -noupdate -expand -group CPU -group forward_wb_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_wb_mux/sel
add wave -noupdate -expand -group CPU -group forward_wb_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_wb_mux/a
add wave -noupdate -expand -group CPU -group forward_wb_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_wb_mux/b
add wave -noupdate -expand -group CPU -group forward_wb_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_wb_mux/c
add wave -noupdate -expand -group CPU -group forward_wb_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_wb_mux/d
add wave -noupdate -expand -group CPU -group forward_wb_mux -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_wb_mux/f
add wave -noupdate -expand -group CPU -group {frw_wb_save - LDI/STI} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_wb_save/clk
add wave -noupdate -expand -group CPU -group {frw_wb_save - LDI/STI} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_wb_save/load
add wave -noupdate -expand -group CPU -group {frw_wb_save - LDI/STI} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_wb_save/in
add wave -noupdate -expand -group CPU -group {frw_wb_save - LDI/STI} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_wb_save/out
add wave -noupdate -expand -group CPU -group {frw_wb_save - LDI/STI} -radix hexadecimal /mp0_tb/dut/cpu_inst/datapath/forward_wb_save/data
add wave -noupdate -group L2 -radix hexadecimal /mp0_tb/dut/l2_inst/control/state
add wave -noupdate -group L2 -radix hexadecimal /mp0_tb/dut/l2_inst/datapath/ctl
add wave -noupdate -group L2 -radix hexadecimal /mp0_tb/dut/l2_inst/datapath/state
add wave -noupdate -group L2 -expand -group mem_sigs -radix hexadecimal /mp0_tb/dut/l2_inst/mem_read
add wave -noupdate -group L2 -expand -group mem_sigs -radix hexadecimal /mp0_tb/dut/l2_inst/mem_write
add wave -noupdate -group L2 -expand -group mem_sigs -radix hexadecimal /mp0_tb/dut/l2_inst/mem_address
add wave -noupdate -group L2 -expand -group mem_sigs -radix hexadecimal /mp0_tb/dut/l2_inst/mem_wdata
add wave -noupdate -group L2 -expand -group mem_sigs -radix hexadecimal /mp0_tb/dut/l2_inst/mem_resp
add wave -noupdate -group L2 -expand -group mem_sigs -radix hexadecimal /mp0_tb/dut/l2_inst/mem_rdata
add wave -noupdate -group L2 -expand -group mem_sigs -radix hexadecimal /mp0_tb/dut/l2_inst/pmem_resp
add wave -noupdate -group L2 -expand -group mem_sigs -radix hexadecimal /mp0_tb/dut/l2_inst/pmem_rdata
add wave -noupdate -group L2 -expand -group mem_sigs -radix hexadecimal /mp0_tb/dut/l2_inst/pmem_read
add wave -noupdate -group L2 -expand -group mem_sigs -radix hexadecimal /mp0_tb/dut/l2_inst/pmem_write
add wave -noupdate -group L2 -expand -group mem_sigs -radix hexadecimal /mp0_tb/dut/l2_inst/pmem_address
add wave -noupdate -group L2 -expand -group mem_sigs -radix hexadecimal /mp0_tb/dut/l2_inst/pmem_wdata
add wave -noupdate -group Prefetcher -radix hexadecimal /mp0_tb/dut/prefetcher/controller/state
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/i_read
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/i_write
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/i_address
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/i_wdata
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/i_resp
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/i_rdata
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/l2_resp
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/l2_rdata
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/l2_read
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/l2_write
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/l2_address
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/l2_wdata
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/pmem_resp
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/pmem_rdata
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/pmem_read
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/pmem_write
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/pmem_address
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/pmem_wdata
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/load_pf_line
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/load_pf_addr
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/i_rdata_sel
add wave -noupdate -group Prefetcher -expand -group datapath -radix hexadecimal /mp0_tb/dut/prefetcher/prefetch_addr_cur
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/mem_read
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/mem_write
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/mem_byte_enable
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/mem_address
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/mem_wdata
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/mem_resp
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/mem_rdata
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/l2_resp
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/l2_rdata
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/l2_read
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/l2_write
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/l2_address
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/l2_wdata
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/eviction
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/load_lru
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/l2wdata_sel
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/load_d0
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/load_v0
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/load_TD0
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/d_set0
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/v_set0
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/load_d1
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/load_v1
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/load_TD1
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/d_set1
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/v_set1
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/l2addr_sel
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/lru
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/lru_set
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/dirty0
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/dirty1
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/valid0
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/valid1
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/hit0
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/hit1
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/l2_address_inter
add wave -noupdate -group i_cache -radix hexadecimal /mp0_tb/dut/i_cache/l2_wdata_inter
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/mem_read
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/mem_write
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/mem_byte_enable
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/mem_address
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/mem_wdata
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/mem_resp
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/mem_rdata
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/l2_resp
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/l2_rdata
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/l2_read
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/l2_write
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/l2_address
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/l2_wdata
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/eviction
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/load_lru
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/l2wdata_sel
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/load_d0
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/load_v0
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/load_TD0
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/d_set0
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/v_set0
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/load_d1
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/load_v1
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/load_TD1
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/d_set1
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/v_set1
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/l2addr_sel
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/lru
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/lru_set
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/dirty0
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/dirty1
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/valid0
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/valid1
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/hit0
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/hit1
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/l2_address_inter
add wave -noupdate -group d-cache -radix hexadecimal /mp0_tb/dut/d_cache/l2_wdata_inter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2003204 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 217
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
WaveRestoreZoom {11680227 ps} {11744315 ps}
