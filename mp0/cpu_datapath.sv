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
    input i_mem_resp,                                   // TODO: Need to use to handle stalling for CP2
    input lc3b_word i_mem_rdata,
    output lc3b_word i_mem_address,
    output logic i_mem_read,

    /* Data Memory signals */
    input d_mem_resp,                                   // TODO: Need to use to handle stalling for CP2
    input lc3b_word d_mem_rdata,
    output lc3b_word d_mem_address,
    output lc3b_word d_mem_wdata,
    output logic d_mem_read, d_mem_write,
    output lc3b_mem_wmask d_mem_byte_enable
);

/********** Internal Signals **********/
logic load;

// Stage 1
lc3b_word pcmux_out, pc_out;
lc3b_word pc_plus_off, pc_plus2_out, addrmux_out;
lc3b_word adj11_offset, adj9_offset;

// Stage 2
logic init_ID_out;
lc3b_word pc_ID_out;
lc3b_ir_10_0 ir_10_0;
lc3b_reg dest_ID_out, src1, src2;
lc3b_reg destmux_out, src2mux_out;
lc3b_word src1_data_out, src2_data_out;
lc3b_word regfilemux_out;
lc3b_nzp gencc_out, cc_out;

// Stage 3
logic init_EX_out;
lc3b_control_word_ex ex_sig_3;
lc3b_control_word_mem mem_sig_3;
lc3b_control_word_wb wb_sig_3;
lc3b_reg dest_EX_out;
lc3b_word pc_EX_out, marmux_EX_out, mdrmux_EX_out, adj6_offset;
lc3b_word src1_data_EX, src2_data_EX, alu_EX_out, alumux_out;
lc3b_imm4 imm4_EX;
lc3b_imm5 imm5_EX;
lc3b_offset6 offset6_EX;
lc3b_trapvect8 trapVect8_EX;
lc3b_offset11 PCoffset11_EX;

// Stage 4
logic init_MEM_out;
lc3b_control_word_mem mem_sig_4;
lc3b_control_word_wb wb_sig_4;
lc3b_reg dest_MEM_out;
lc3b_word pc_MEM_out, mar_MEM_out, alu_MEM_out, indirectmux_out;
lc3b_offset11 PCoffset11_MEM;

// Stage 5
logic init_WB_out;
logic addrmux_sel;
logic [1:0] pcmux_sel;
logic br_enable;
lc3b_control_word_wb wb_sig_5;
lc3b_reg dest_WB_out;
lc3b_word pc_WB_out, mdr_WB_out, mdr_WB_mod, alu_WB_out;
lc3b_offset9 PCoffset9_WB;
lc3b_offset11 PCoffset11_WB;

/************************* Stage 1 *************************/
/***** PC *****/
mux4 pcmux
(
    .sel(pcmux_sel),
    .a(pc_plus2_out),
    .b(pc_plus_off),
    .c(alu_WB_out),
    .d(mdr_WB_mod),
    .f(pcmux_out)
);

register pc
(
    .clk,
    .load(load),
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
    .clk, .load(load),

    /* data inputs */
    .pc_ID_in(pc_plus2_out), .ir_in(i_mem_rdata),

    /* data outputs */
    .pc_ID_out(pc_ID_out), .opcode(opcode), .dest_ID_out(dest_ID_out),
    .src1(src1), .src2(src2), .ir_10_0(ir_10_0), .init_ID_out(init_ID_out)
);

mux2 #(3) destmux
(
    .sel(wb_sig_5.destmux_sel),
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
    .load(wb_sig_5.load_regfile),
    .in(regfilemux_out),
    .src_a(src1),
    .src_b(src2mux_out),
    .dest(destmux_out),
    .reg_a(src1_data_out),
    .reg_b(src2_data_out)
);

mux4 regfilemux
(
    .sel(wb_sig_5.regfilemux_sel),
    .a(alu_WB_out),
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
    .load(wb_sig_5.load_cc),
    .in(gencc_out),
    .out(cc_out)
);

cccomp cccomp_inst
(
    .cur_cc(cc_out),
    .br_cc(dest_WB_out),
    .br_enable(br_enable)
);

/************************* Stage 3 *************************/
/***** ID_EX Pipeline Register *****/
id_ex ID_EX
(
    .clk, .load(load),

    /* control inputs */
    .ex_sig_in(cw.ex), .mem_sig_in(cw.mem), .wb_sig_in(cw.wb),

    /* control outputs */
    .ex_sig_out(ex_sig_3), .mem_sig_out(mem_sig_3), .wb_sig_out(wb_sig_3),

    /* data inputs */
    .dest_EX_in(dest_ID_out), .pc_EX_in(pc_ID_out),
    .src1_data_in(src1_data_out), .src2_data_in(src2_data_out),
    .ir_10_0_in(ir_10_0), .init_EX_in(init_ID_out),

    /* data outputs */
    .dest_EX_out(dest_EX_out), .pc_EX_out(pc_EX_out),
    .src1_data_EX(src1_data_EX), .src2_data_EX(src2_data_EX),

    .imm4_EX(imm4_EX), .imm5_EX(imm5_EX), .offset6_EX(offset6_EX),
    .trapVect8_EX(trapVect8_EX), .offset11_EX_out(PCoffset11_EX),
    .init_EX_out(init_EX_out)
);

adj #(6) offset6_adjuster
(
    .lsse(ex_sig_3.offset6_lsse),
    .in(offset6_EX),
    .out(adj6_offset)
);

mux4 alumux
(
    .sel(ex_sig_3.alumux_sel),
    .a(src2_data_EX),
    .b({12'h000,imm4_EX}),
    .c({{11{imm5_EX[4]}},imm5_EX}),
    .d(adj6_offset),
    .f(alumux_out)
);

alu alu_inst
(
    .aluop(ex_sig_3.aluop),
    .a(src1_data_EX),
    .b(alumux_out),
    .f(alu_EX_out)
);

mux2 marmux_ex
(
    .sel(ex_sig_3.marmux_EX_sel),
    .a(alu_EX_out),
    .b({7'h00,trapVect8_EX,1'b0}),
    .f(marmux_EX_out)
);

mux4 mdrmux_ex
(
    .sel(ex_sig_3.mdrmux_EX_sel),
    .a(alu_EX_out),
    .b({8'h00, alu_EX_out[7:0]}),
    .c({alu_EX_out[7:0], 8'h00}),
    .d(src2_data_EX),
    .f(mdrmux_EX_out)
);


/************************* Stage 4 *************************/
/***** EX_MEM Pipeline Register *****/
ex_mem EX_MEM
(
    .clk, .load(load),

    /* control inputs */
    .mem_sig_in(mem_sig_3), .wb_sig_in(wb_sig_3),

    /* control outputs */
    .mem_sig_out(mem_sig_4), .wb_sig_out(wb_sig_4),

    /* data inputs */
    .dest_MEM_in(dest_EX_out), .pc_MEM_in(pc_EX_out),
    .alu_MEM_in(alu_EX_out), .mar_MEM_in(marmux_EX_out),
    .mdr_MEM_in(mdrmux_EX_out), .offset11_MEM_in(PCoffset11_EX),
    .init_MEM_in(init_EX_out),

    /* data outputs */
    .dest_MEM_out(dest_MEM_out), .pc_MEM_out(pc_MEM_out),
    .alu_MEM_out(alu_MEM_out), .mar_MEM_out(mar_MEM_out),
    .mdr_MEM_out(d_mem_wdata), .offset11_MEM_out(PCoffset11_MEM),
    .init_MEM_out(init_MEM_out)
);

mux2 indirectmux
(
    .sel(mem_sig_4.indirectmux_sel),
    .a(mar_MEM_out),
    .b(mdr_WB_mod),
    .f(indirectmux_out)
);

/************************* Stage 5 *************************/
/***** MEM_WB Pipeline Register *****/
mem_wb MEM_WB
(
    .clk, .load(load),

    /* control Signals */
    .wb_sig_in(wb_sig_4),

    /* control outputs */
    .wb_sig_out(wb_sig_5),

    /* data inputs */
    .dest_WB_in(dest_MEM_out),
    .pc_WB_in(pc_MEM_out), .alu_WB_in(alu_MEM_out),
    .mdr_WB_in(d_mem_rdata), .offset11_WB_in(PCoffset11_MEM),
    .init_WB_in(init_MEM_out),

    /* data outputs */
    .dest_WB_out(dest_WB_out), .pc_WB_out(pc_WB_out),
    .alu_WB_out(alu_WB_out), .mdr_WB_out(mdr_WB_out),
    .offset9_WB_out(PCoffset9_WB), .offset11_WB_out(PCoffset11_WB),
    .init_WB_out(init_WB_out)
);

mux4 mdrmux_wb
(
    .sel(wb_sig_5.mdrmux_WB_sel),
    .a(mdr_WB_out),
    .b({8'h00, mdr_WB_out[7:0]}),
    .c({8'h00, mdr_WB_out[15:8]}),
    .d(16'h0000),
    .f(mdr_WB_mod)
);

// Data Memory Signals
assign d_mem_address =  indirectmux_out;
assign d_mem_read = mem_sig_4.d_mem_read;
assign d_mem_write = mem_sig_4.d_mem_write;
assign d_mem_byte_enable = mem_sig_4.d_mem_byte_enable;

// Instruction Memory Signals
assign i_mem_address = pc_out;
assign i_mem_read = 1'b1;

// Control Signals
assign ir_4 = ir_10_0[4];
assign ir_5 = ir_10_0[5];
assign ir_11 = dest_ID_out[2];

// assign load = (d_mem_resp | (~init_MEM_out)
//               | (mem_sig_4.load_pipe_mem & wb_sig_5.load_pipe_wb)
//               | (mem_sig_4.load_pipe_mem & (~init_WB_out))) & (~(mem_sig_4.d_mem_read ^ mem_sig_4.d_mem_write));
// TODO: Needs to change to handle stalling
assign load = 1'b1;

/***** pcmux_sel and addrmux_sel logic *****/
always_comb
begin
    pcmux_sel = 2'b00;
    addrmux_sel = 1'b0;
    case (wb_sig_5.opcode)
        op_br: begin
            if(br_enable)
                pcmux_sel = 2'b01;
        end
        op_jmp: begin
            pcmux_sel = 2'b10;
        end
        op_jsr: begin
            addrmux_sel = 1'b1;
            if(ir_11)
                pcmux_sel = 2'b01;
            else
                pcmux_sel = 2'b10;
        end
        op_trap: begin
            pcmux_sel = 2'b11;
        end
        default: pcmux_sel = 2'b00;
    endcase
end

endmodule : cpu_datapath
