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
    input i_mem_resp,
    input lc3b_word i_mem_rdata,
    output lc3b_word i_mem_address,
    output logic i_mem_read,

    /* Data Memory signals */
    input d_mem_resp,
    input lc3b_word d_mem_rdata,
    output lc3b_word d_mem_address,
    output lc3b_word d_mem_wdata,
    output logic d_mem_read, d_mem_write,
    output lc3b_mem_wmask d_mem_byte_enable
);

/********** Internal Signals **********/
logic load, load_mem_wb;
logic load_pc, load_pcbak;
logic control_instruc_ident, control_instruc_ident_wb;

/**** Stage 1 ****/
lc3b_word pcmux_out, pc_out, pcbak_out, pcPlus2mux_out;
lc3b_word pc_plus2_out, addrmux_out;
lc3b_word adj11_offset, adj9_offset;
lc3b_word irmux_out;

/**** Stage 2 ****/
lc3b_word pc_ID_out;
lc3b_ir_10_0 ir_10_0;
lc3b_reg dest_ID_out, src1, src2;
lc3b_reg destmux_out, src2mux_out;
lc3b_word src1_data_out, src2_data_out;
lc3b_word regfilemux_out;
lc3b_nzp gencc_out, cc_out;

/**** Stage 3 ****/
logic [1:0] mdrmux_EX_sel;
lc3b_control_word_ex ex_sig_3;
lc3b_control_word_mem mem_sig_3;
lc3b_control_word_wb wb_sig_3;
lc3b_reg dest_EX_out;
lc3b_word pc_EX_out, pc_plus_off_EX, marmux_EX_out, mdrmux_EX_out, adj6_offset;
lc3b_word src1_data_EX, src2_data_EX, alu_EX_out, alumux_out;
lc3b_imm4 imm4_EX;
lc3b_imm5 imm5_EX;
lc3b_offset6 offset6_EX;
lc3b_trapvect8 trapVect8_EX;
lc3b_offset11 PCoffset11_EX;

// forwarding signals
lc3b_reg src1_EX_out, src2_EX_out;
lc3b_word forward_sr1_out, forward_sr2_out;
lc3b_forward_ex forward_EX_sigs;
logic [1:0] forward_a_EX_sel, forward_b_EX_sel;

/**** Stage 4 ****/
lc3b_control_word_mem mem_sig_4;
lc3b_control_word_wb wb_sig_4;
lc3b_control_word_wb wb_sig_4_inter;
lc3b_reg dest_MEM_out;
lc3b_word pc_MEM_out, pc_plus_off_MEM, mar_MEM_out, alu_MEM_out, d_mem_address_out;
lc3b_offset11 PCoffset11_MEM;

// forwarding signals
// Mem -> EX
lc3b_reg src1_MEM_out, src2_MEM_out;
lc3b_word forward_MEM_out;
logic [1:0] forward_MEM_sel;

// WB -> MEM
lc3b_forward_mem forward_MEM_sigs;
lc3b_word forward_MEM_address, adj6_offset_MEM;
logic [1:0] forward_MEM_data_sel;
logic forward_MEM_addr_sel;

/**** Stage 5 ****/
logic addrmux_sel, indirectmux_sel;
logic [1:0] pcmux_sel, mdrmux_WB_sel;
logic br_enable;
lc3b_control_word_wb wb_sig_5;
lc3b_reg dest_WB_out;
lc3b_word mar_WB_out;
lc3b_word pc_WB_out, pc_plus_off_WB;
lc3b_word mdr_MEM_out, mdr_WB_out, mdr_WB_mod, alu_WB_out;
lc3b_word wdata_forward_out;
lc3b_word mdr_wb_in_mux_out;

// forwarding signals
// WB -> EX
lc3b_word forward_WB_out;
logic [1:0] forward_WB_sel;
lc3b_forward_save forward_save_in, forward_save_out;


/************************* Hazard Detection *************************/
hazard_detection hazard_detection_inst
(
    /* inputs */
    .br_enable(br_enable),
    .i_mem_resp, .d_mem_resp,
    .d_mem_read, .d_mem_write,
    .MEM_inter_read(wb_sig_4_inter.d_mem_read), .MEM_inter_write(wb_sig_4_inter.d_mem_write),
    .op_ID(opcode), .op_EX(wb_sig_3.opcode),
    .op_MEM(wb_sig_4.opcode), .op_MEM_inter(wb_sig_4_inter.opcode),
    .op_WB(wb_sig_5.opcode),
    .nzp_ID(dest_ID_out), .nzp_EX(dest_EX_out), .nzp_MEM(dest_MEM_out), .nzp_WB(dest_WB_out),

    /* outputs */
    .load, .load_pc, .load_pcbak,
    .control_instruc_ident_wb, .i_mem_read(i_mem_read)
);

forwarding_unit forwarding
(
    .forward_EX(forward_EX_sigs),
    .forward_MEM(forward_MEM_sigs),
    .forward_save(forward_save_out),
    .indirectmux_sel(indirectmux_sel),
    .address_MEM(d_mem_address_out),
    .address_WB(mar_WB_out),
	.forward_a_EX_sel(forward_a_EX_sel),
	.forward_b_EX_sel(forward_b_EX_sel),
    .forward_MEM_data_sel(forward_MEM_data_sel),
    .forward_MEM_addr_sel(forward_MEM_addr_sel),
    .mdr_wb_in_mux_sel(mdr_wb_in_mux_sel)
);

/************************* Stage 1 *************************/
/***** PC *****/
mux4 pcmux
(
    .sel(pcmux_sel),
    .a(pc_plus2_out),
    .b(pc_plus_off_WB),
    .c(alu_WB_out),
    .d(mdr_WB_mod),
    .f(pcmux_out)
);

register pc
(
    .clk,
    .load(load_pc),
    .in(pcmux_out),
    .out(pc_out)
);

register pcbak
(
    .clk,
    .load(load_pcbak),
    .in(pcmux_out),
    .out(pcbak_out)
);

// increments PC value to access next instruction
plus2 pcPlus2
(
    .in(pc_out),
    .out(pc_plus2_out)
);

mux2 irmux
(
    .sel(i_mem_resp),
    .a(16'h0000),
    .b(i_mem_rdata),
    .f(irmux_out)
);


/************************* Stage 2 *************************/
/***** IF_ID Pipeline Register *****/
if_id IF_ID
(
    .clk, .load(load & (~control_instruc_ident_wb)),

    /* data inputs */
    .pc_ID_in(pc_plus2_out), .ir_in(irmux_out),

    /* data outputs */
    .pc_ID_out(pc_ID_out), .opcode(opcode), .dest_ID_out(dest_ID_out),
    .src1(src1), .src2(src2), .ir_10_0(ir_10_0)
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
    .c(pc_plus_off_WB),
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
    .src1_EX_in(src1), .src2_EX_in(src2mux_out),
    .src1_data_in(src1_data_out), .src2_data_in(src2_data_out),
    .ir_10_0_in(ir_10_0),

    /* data outputs */
    .dest_EX_out(dest_EX_out), .pc_EX_out(pc_EX_out),
    .src1_EX_out(src1_EX_out), .src2_EX_out(src2_EX_out),
    .src1_data_EX(src1_data_EX), .src2_data_EX(src2_data_EX),

    .imm4_EX(imm4_EX), .imm5_EX(imm5_EX), .offset6_EX(offset6_EX),
    .trapVect8_EX(trapVect8_EX), .offset11_EX_out(PCoffset11_EX)
);

mux4 forward_sr1_mux
(
    .sel(forward_a_EX_sel),
    .a(src1_data_EX),
    .b(forward_MEM_out),
    .c(forward_WB_out),
    .d(forward_save_out.forward_val),
    .f(forward_sr1_out)
);

mux4 forward_sr2_mux
(
    .sel(forward_b_EX_sel),
    .a(src2_data_EX),
    .b(forward_MEM_out),
    .c(forward_WB_out),
    .d(forward_save_out.forward_val),
    .f(forward_sr2_out)
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
    .a(forward_sr2_out),
    .b({12'h000,imm4_EX}),
    .c({{11{imm5_EX[4]}},imm5_EX}),
    .d(adj6_offset),
    .f(alumux_out)
);

alu alu_inst
(
    .aluop(ex_sig_3.aluop),
    .a(forward_sr1_out),
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
    .sel(mdrmux_EX_sel),
    .a(16'h0000),
    .b({8'h00, src2_data_EX[7:0]}),
    .c({src2_data_EX[7:0], 8'h00}),
    .d(src2_data_EX),
    .f(mdrmux_EX_out)
);

adder pc_plus_off_adder
(
    .a(pc_EX_out),
    .b(addrmux_out),
    .c(pc_plus_off_EX)
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
    .in(PCoffset11_EX[8:0]),        // pc offset 9
    .out(adj9_offset)
);

adj #(11) offset11_adjuster
(
    .lsse(1'b1),
    .in(PCoffset11_EX),
    .out(adj11_offset)
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
    .src1_MEM_in(src1_EX_out), .src2_MEM_in(src2_EX_out),
    .pcp_off_MEM_in(pc_plus_off_EX), .offset11_MEM_in(PCoffset11_EX),
    .alu_MEM_in(alu_EX_out), .mar_MEM_in(marmux_EX_out),
    .mdr_MEM_in(mdrmux_EX_out), .mem_byte_enable_in(mdrmux_EX_sel),


    /* data outputs */
    .dest_MEM_out(dest_MEM_out), .pc_MEM_out(pc_MEM_out),
    .src1_MEM_out(src1_MEM_out), .src2_MEM_out(src2_MEM_out),
    .pcp_off_MEM_out(pc_plus_off_MEM), .offset11_MEM_out(PCoffset11_MEM),
    .alu_MEM_out(alu_MEM_out), .mar_MEM_out(mar_MEM_out),
    .mdr_MEM_out(mdr_MEM_out), .mem_byte_enable_out(d_mem_byte_enable)
);

mux4 forward_mem_mux
(
    .sel(mem_sig_4.forward_MEM_sel),
    .a(alu_MEM_out),
    .b(pc_MEM_out),
    .c(pc_plus_off_MEM),
    .d(d_mem_rdata),
    .f(forward_MEM_out)
);


mux4 dmem_data_mux
(
    .sel(forward_MEM_data_sel),
    .a(mdr_MEM_out),
    .b(forward_WB_out),
    .c(forward_save_out.forward_val),
    .d(16'h0000),
    .f(d_mem_wdata)
);

mux4 dmem_address_mux
(
    .sel({forward_MEM_addr_sel,indirectmux_sel}),
    .a(mar_MEM_out),
    .b(mdr_WB_out),
    .c(forward_MEM_address),
    .d(mdr_WB_out),
    .f(d_mem_address_out)
);

adder address_adder
(
    .a(forward_WB_out),
    .b(adj6_offset_MEM),
    .c(forward_MEM_address)
);

adj #(6) offset6_adjuster_MEM
(
    .lsse(mem_sig_4.offset6_lsse),
    .in(PCoffset11_MEM[5:0]),
    .out(adj6_offset_MEM)
);

mux2 mdr_wb_in_mux
(
    .sel(mdr_wb_in_mux_sel),
    .a(d_mem_rdata),
    .b(wdata_forward_out),
    .f(mdr_wb_in_mux_out)
);

/************************* Stage 5 *************************/
/***** MEM_WB Pipeline Register *****/
mem_wb MEM_WB
(
    .clk, .load(load_mem_wb),

    /* control Signals */
    .wb_sig_in(wb_sig_4_inter),

    /* control outputs */
    .wb_sig_out(wb_sig_5),

    /* data inputs */
    .dest_WB_in(dest_MEM_out),
    .pc_WB_in(pc_MEM_out), .alu_WB_in(alu_MEM_out),
    .pcp_off_WB_in(pc_plus_off_MEM),
    .mdr_WB_in(mdr_wb_in_mux_out), .mar_WB_in(d_mem_address_out),
    .wdata_mem(d_mem_wdata),

    /* data outputs */
    .dest_WB_out(dest_WB_out), .pc_WB_out(pc_WB_out),
    .pcp_off_WB_out(pc_plus_off_WB),
    .alu_WB_out(alu_WB_out), .mdr_WB_out(mdr_WB_out),
    .mar_WB_out(mar_WB_out),
    .wdata_forward_out(wdata_forward_out)
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

mux4 forward_wb_mux
(
    .sel(wb_sig_5.forward_WB_sel),
    .a(alu_WB_out),
    .b(pc_WB_out),
    .c(pc_plus_off_WB),
    .d(mdr_WB_mod),
    .f(forward_WB_out)
);

/* Control Signal Registers */
register #($bits(lc3b_forward_save)) forward_wb_save
(
    .clk,
    .load(load_mem_wb^load),
    .in(forward_save_in),
    .out(forward_save_out)
);

// Data Memory Signals
assign d_mem_address =  d_mem_address_out;
assign d_mem_read = ({wb_sig_5.d_mem_read, wb_sig_5.d_mem_write} == 2'b00) ? mem_sig_4.d_mem_read : wb_sig_5.d_mem_read;
assign d_mem_write = ({wb_sig_5.d_mem_read, wb_sig_5.d_mem_write} == 2'b00) ? mem_sig_4.d_mem_write : wb_sig_5.d_mem_write;

// Instruction Memory Signals
assign i_mem_address = pc_out;

// Control Signals
assign ir_4 = ir_10_0[4];
assign ir_5 = ir_10_0[5];
assign ir_11 = dest_WB_out[2];
assign load_mem_wb = load | d_mem_resp;

// LDI/STI control signal
assign wb_sig_4_inter.d_mem_read = ((wb_sig_5.opcode == op_ldi || wb_sig_5.opcode == op_sti) && {wb_sig_5.d_mem_read, wb_sig_5.d_mem_write} != 2'b00) ? 1'b0 : wb_sig_4.d_mem_read;
assign wb_sig_4_inter.d_mem_write = ((wb_sig_5.opcode == op_ldi || wb_sig_5.opcode == op_sti) && {wb_sig_5.d_mem_read, wb_sig_5.d_mem_write} != 2'b00) ? 1'b0 : wb_sig_4.d_mem_write;
assign wb_sig_4_inter.opcode = wb_sig_4.opcode;
assign wb_sig_4_inter.destmux_sel = wb_sig_4.destmux_sel;
assign wb_sig_4_inter.regfilemux_sel = wb_sig_4.regfilemux_sel;
assign wb_sig_4_inter.load_cc = wb_sig_4.load_cc;
assign wb_sig_4_inter.load_regfile = wb_sig_4.load_regfile;
assign wb_sig_4_inter.forward_WB_sel = wb_sig_4.forward_WB_sel;

// forwarding signals assignment MEM/WB -> EX
assign forward_EX_sigs.dest_mem = dest_MEM_out;
assign forward_EX_sigs.dest_wb = dest_WB_out;
assign forward_EX_sigs.src1_ex = src1_EX_out;
assign forward_EX_sigs.src2_ex = src2_EX_out;
assign forward_EX_sigs.load_regfile_mem = wb_sig_4.load_regfile;
assign forward_EX_sigs.load_regfile_wb = wb_sig_5.load_regfile;

// forwarding signals assignment WB -> MEM
assign forward_MEM_sigs.load_regfile_wb = wb_sig_5.load_regfile;
assign forward_MEM_sigs.dest_wb = dest_WB_out;
assign forward_MEM_sigs.sourceR_mem = dest_MEM_out;
assign forward_MEM_sigs.baseR_mem = src1_MEM_out;

// save wb for LDI and STI
assign forward_save_in.load_regfile_wb = wb_sig_5.load_regfile;
assign forward_save_in.forward_val = forward_WB_out;
assign forward_save_in.dest_wb = dest_WB_out;

/***** pcmux_sel logic *****/
always_comb begin
    pcmux_sel = 2'b00;
    case (wb_sig_5.opcode)
        op_br: begin
            if(br_enable)
                pcmux_sel = 2'b01;
        end
        op_jmp: begin
            pcmux_sel = 2'b10;
        end
        op_jsr: begin
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

/***** addrmux_sel logic *****/
always_comb begin
    addrmux_sel = 1'b0;
    if(wb_sig_3.opcode == op_jsr)
        addrmux_sel = 1'b1;
end

/***** mdrmux_WB_sel and mdrmux_EX_sel logic *****/
always_comb begin
    mdrmux_EX_sel = 2'b11;
    if(wb_sig_3.opcode == op_stb) begin
        if(alu_EX_out[0] == 1)
            mdrmux_EX_sel = 2'b10;
        else
            mdrmux_EX_sel = 2'b01;
    end

    mdrmux_WB_sel = 2'b00;
    if(wb_sig_5.opcode == op_ldb) begin
        if(mar_WB_out[0] == 1)
            mdrmux_WB_sel = 2'b10;
        else
            mdrmux_WB_sel = 2'b01;
    end
end

/***** indirectmux_sel logic *****/
always_comb begin
    indirectmux_sel = 1'b0;
    if((wb_sig_5.opcode == op_ldi || wb_sig_5.opcode == op_sti) && {wb_sig_5.d_mem_read, wb_sig_5.d_mem_write} != 2'b00)
        indirectmux_sel = 1'b1;
end

endmodule : cpu_datapath
