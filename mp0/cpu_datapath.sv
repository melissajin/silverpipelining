import lc3b_types::*;

module cpu_datapath
(
    input clk,

    /* Control Signals */
    input lc3b_control_word cw,
    output lc3b_opcode opcode,
    output logic ir_4,
    output logic ir_5,
    output logic ir_11,

    /* Instruction Memory signals */
    input lc3b_word i_mem_rdata,
    output lc3b_word i_mem_address,

    /* Data Memory signals */
    input lc3b_word d_mem_rdata,
    output lc3b_word d_mem_address,
    output lc3b_word d_mem_wdata
);

// Memory Signals
assign i_mem_address = pc_out;

// Control Signals
assign ir_4 = ir_10_0[4];
assign ir_5 = ir_10_0[5];
assign ir_11 = dest_ID_out[2];

// Stage 1
lc3b_word pcmux_out, pc_out;
lc3b_word pc_plus_off, pc_plus2_out, addrmux_out;
lc3b_word adj11_offset, adj9_offset;

// Stage 2
lc3b_word pc_ID_out;
lc3b_ir_10_0 ir_10_0;
lc3b_reg dest_ID_out, src1, src2;
lc3b_reg destmux_out, src2mux_out;
lc3b_word src1_data_out, src2_data_out;
lc3b_word regfilemux_out;
lc3b_nzp gencc_out, cc_out;

// Stage 3
lc3b_control_word_ex ex_sig_3;
lc3b_control_word_mem mem_sig_3;
lc3b_control_word_wb wb_sig_3;
lc3b_reg dest_EX_out;
lc3b_word pc_EX_out, marmux_EX_out, mdrmux_EX_out;
lc3b_word src1_data_EX, src2_data_EX, alu_out, alumux_out;
lc3b_imm4 imm4_EX;
lc3b_imm5 imm5_EX;
lc3b_offset6 offset6_EX, adj6_offset;
lc3b_trapvect8 trapVect8_EX;
lc3b_offset11 PCoffset11_EX;

// Stage 4
lc3b_control_word_mem mem_sig_4;
lc3b_control_word_wb wb_sig_4;
lc3b_reg dest_MEM_out;
lc3b_word pc_MEM_out, mar_MEM_out;
lc3b_offset11 PCoffset11_MEM;

// Stage 5
lc3b_control_word_wb wb_sig_5;
lc3b_reg dest_WB_out;
lc3b_word pc_WB_out, mdr_WB_out, mdr_WB_mod;
lc3b_offset9 PCoffset9_WB;
lc3b_offset11 PCoffset11_WB;


/************************* Stage 1 *************************/
/***** PC *****/
mux4 pcmux
(
    .sel(pcmux_sel),
    .a(pc_plus2_out),
    .b(pc_plus_off),
    .c(alu_out),
    .d(mdr_WB_mod),
    .f(pcmux_out)
);

register pc
(
    .clk,
    .load(1'b1),                // Since PC is always being loaded
    .in(pcmux_out),
    .out(pc_out)
);

// increments PC value to access next instruction
plus2 pcPlus2
(
    .in(pc_out),
    .out(pc_plus2_out)
);

adder pc_plus_off_adder
(
    .a(pc_WB_out),
    .b(addrmux_out),
    .c(pc_plus_off)
);

mux2 addrmux
(
    .sel(addrmux_sel),
    .a(adj9_offset),
    .b(adj11_offset),
    .f(addrmux_out)
);

adj #(9) offset9_adjuster
(
    .lsse(1'b1),
    .in(PCoffset9_WB),
    .out(adj9_offset)
);

adj #(11) offset11_adjuster
(
    .lsse(1'b1),
    .in(PCoffset11_WB),
    .out(adj11_offset)
);


/************************* Stage 2 *************************/
/***** IF_ID Pipeline Register *****/
if_id IF_ID
(
    /* inputs */
    .clk, .pc_ID_in(pc_plus2_out), .ir_in(i_mem_rdata),

    /* outputs */
    .pc_ID_out(pc_ID_out), .opcode(opcode), .dest_ID_out(dest_ID_out),
    .src1(src1), .src2(src2), .ir_10_0(ir_10_0)
);

mux2 #(3) destmux
(
    .sel(destmux_sel),
    .a(dest_WB_out),
    .b(3'b111),
    .f(destmux_out)
);

mux2 #(3) src2mux
(
    .sel(cw.src2mux_sel),
    .a(src2),
    .b(dest_ID_out),
    .f(src2mux_out)
);

/***** Regfile *****/
regfile regfile_inst
(
    .clk,
    .load(load_regfile),
    .in(regfilemux_out),
    .src_a(src1),
    .src_b(src2mux_out),
    .dest(destmux_out),
    .reg_a(src1_data_out),
    .reg_b(src2_data_out)
);

mux4 regfilemux
(
    .sel(regfilemux_sel),
    .a(alu_out),
    .b(mdr_WB_mod),
    .c(pc_plus_off),
    .d(pc_WB_out),
    .f(regfilemux_out)
);

/***** Condition Codes Modules *****/
gencc gencc_inst
(
    .in(regfilemux_out),
    .out(gencc_out)
);

register #(3) cc
(
    .clk,
    .load(load_cc),
    .in(gencc_out),
    .out(cc_out)
);

cccomp cccomp_inst
(
    .cur_cc(cc_out),
    .br_cc(dest_WB_out),
    .br_enable(/*TODO*/)
);

/************************* Stage 3 *************************/
/***** ID_EX Pipeline Register *****/
id_ex ID_EX
(
    /* control inputs */
    .ex_sig_in(cw.ex), .mem_sig_in(cw.mem), .wb_sig_in(cw.wb),

    /* control outputs */
    .ex_sig_in(ex_sig_3), .mem_sig_out(mem_sig_3), .wb_sig_out(wb_sig_3),

    /* data inputs */
    .clk, .dest_EX_in(dest_ID_out), .pc_EX_in(pc_ID_out),
    .src1_data_in(src1_data_out), .src2_data_in(src2_data_out),
    .ir_10_0_in(ir_10_0),

    /* data outputs */
    .dest_EX_out(dest_EX_out), .pc_EX_out(pc_EX_out),
    .src1_data_EX(src1_data_EX), .src2_data_EX(src2_data_EX),

    .imm4_EX(imm4_EX), .imm5_EX(imm5_EX), .offset6_EX(offset6_EX),
    .trapVect8_EX(trapVect8_EX), .offset11_EX_out(PCoffset11_EX)
);

adj #(6) offset6_adjuster
(
    .lsse(offset6_lsse),
    .in(offset6_EX),
    .out(adj6_offset)
);

mux4 alumux
(
    .sel(alumux_sel),
    .a(src2_data_EX),
    .b({12'h000,imm4_EX}),
    .c({{11{imm5_EX[4]}},imm5_EX}),
    .d(adj6_offset),
    .f(alumux_out)
);

alu alu_inst
(
    .aluop(aluop),
    .a(src1_data_EX),
    .b(alumux_out),
    .f(alu_out)
);

mux2 marmux_ex
(
    .sel(marmux_EX_sel),
    .a(alu_out),
    .b({7'h00,trapVect8_EX,1'b0}),
    .f(marmux_EX_out)
);

mux4 mdrmux_ex
(
    .sel(mdrmux_EX_sel),
    .a(alu_out),
    .b({8'h00, alu_out[7:0]}),
    .c({alu_out[7:0], 8'h00}),
    .d(src2_data_EX),
    .f(mdrmux_EX_out)
);


/************************* Stage 4 *************************/
/***** EX_MEM Pipeline Register *****/
ex_mem EX_MEM
(
    /* control inputs */
    .mem_sig_in(mem_sig_3), .wb_sig_in(wb_sig_3),

    /* control outputs */
    .mem_sig_out(mem_sig_4), .wb_sig_out(wb_sig_4),

    /* data inputs */
    .clk, .dest_MEM_in(dest_EX_out), .pc_MEM_in(pc_EX_out),
    .mar_MEM_in(marmux_EX_out), .mdr_MEM_in(mdrmux_EX_out),
    .offset11_MEM_in(PCoffset11_EX),

    /* data outputs */
    .dest_MEM_out(dest_MEM_out), .pc_MEM_out(pc_MEM_out),
    .mar_MEM_out(mar_MEM_out), .mdr_MEM_out(d_mem_wdata),
    .offset11_MEM_out(PCoffset11_MEM)
);

mux2 indirectmux
(
    .sel(indirectmux_sel),
    .a(mar_MEM_out),
    .b(mdr_WB_mod),
    .f(d_mem_address)
);

/************************* Stage 5 *************************/
/***** MEM_WB Pipeline Register *****/
mem_wb MEM_WB
(
    /* control Signals */
    .wb_sig_in(wb_sig_4),

    /* control outputs */
    .wb_sig_out(wb_sig_5),

    /* data inputs */
    .clk, .dest_WB_in(dest_MEM_out),
    .pc_WB_in(pc_MEM_out), .mdr_WB_in(d_mem_rdata),
    .offset11_WB_in(PCoffset11_MEM),

    /* data outputs */
    .dest_WB_out(dest_WB_out),
    .pc_WB_out(pc_WB_out), .mdr_WB_out(mdr_WB_out),
    .offset9_WB_out(PCoffset9_WB), .offset11_WB_out(PCoffset11_WB)
);

mux4 mdrmux_wb
(
    .sel(mdrmux_WB_sel),
    .a(mdr_WB_out),
    .b({8'h00, mdr_WB_out[7:0]}),
    .c({8'h00, mdr_WB_out[15:8]}),
    .d(16'h0000),
    .f(mdr_WB_mod)
);

endmodule : cpu_datapath
