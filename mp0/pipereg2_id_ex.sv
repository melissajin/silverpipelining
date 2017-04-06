import lc3b_types::*;

module id_ex
(
    input clk, load,

    /* control inputs */
    input lc3b_control_word_ex ex_sig_in,
    input lc3b_control_word_mem mem_sig_in,
    input lc3b_control_word_wb wb_sig_in,

    /* control outputs */
    output lc3b_control_word_ex ex_sig_out,
    output lc3b_control_word_mem mem_sig_out,
    output lc3b_control_word_wb wb_sig_out,

    /* data inputs */
    input lc3b_reg dest_EX_in,
    input lc3b_reg src1_EX_in,
    input lc3b_reg src2_EX_in,
    input lc3b_word pc_EX_in,
    input lc3b_word src1_data_in, src2_data_in,
    input lc3b_ir_10_0 ir_10_0_in,
    input logic init_EX_in,

    /* data outputs */
    output lc3b_reg dest_EX_out,
    output lc3b_reg src1_EX_out,
    output lc3b_reg src2_EX_out,
    output lc3b_word pc_EX_out,
    output lc3b_word src1_data_EX, src2_data_EX,

    output lc3b_imm4 imm4_EX,
    output lc3b_imm5 imm5_EX,
    output lc3b_offset6 offset6_EX,
    output lc3b_trapvect8 trapVect8_EX,
    output lc3b_offset11 offset11_EX_out,
    output logic init_EX_out
);


/* Control Signal Registers */
register #($bits(lc3b_control_word_ex)) ex_sig
(
    .clk,
    .load,
    .in(ex_sig_in),
    .out(ex_sig_out)
);

register #($bits(lc3b_control_word_mem)) mem_sig
(
    .clk,
    .load,
    .in(mem_sig_in),
    .out(mem_sig_out)
);

register #($bits(lc3b_control_word_wb)) wb_sig
(
    .clk,
    .load,
    .in(wb_sig_in),
    .out(wb_sig_out)
);

register #(3) dest_ex
(
    .clk,
    .load,
    .in(dest_EX_in),
    .out(dest_EX_out)
);

register #(3) src1_ex
(
    .clk,
    .load,
    .in(src1_EX_in),
    .out(src1_EX_out)
);
register #(3) src2_ex
(
    .clk,
    .load,
    .in(src2_EX_in),
    .out(src2_EX_out)
);

register pc_ex
(
    .clk,
    .load,
    .in(pc_EX_in),
    .out(pc_EX_out)
);

register src1_data_reg
(
    .clk,
    .load,
    .in(src1_data_in),
    .out(src1_data_EX)
);

register src2_data_reg
(
    .clk,
    .load,
    .in(src2_data_in),
    .out(src2_data_EX)
);

/* IR[10:0] */
ir_ex_reg ir_ex_reg_inst
(
    .clk, .load, .in(ir_10_0_in),
    .imm4(imm4_EX), .imm5(imm5_EX),
    .offset6(offset6_EX), .trapVect8(trapVect8_EX),
    .offset11(offset11_EX_out)
);

register #(1) init_ex
(
    .clk,
    .load(1'b1),
    .in(init_EX_in),
    .out(init_EX_out)
);

endmodule : id_ex
