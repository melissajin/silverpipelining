import lc3b_types::*;

module id_ex
(
    input clk, load, clear,

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
    input prediction_EX_in,

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
    output logic prediction_EX_out
);

register_with_clear #(.width(1)) prediction
(
    .clk,
    .load,
    .clear,
    .in(prediction_EX_in),
    .out(prediction_EX_out)
);

/* Control Signal Registers */
register_with_clear #($bits(lc3b_control_word_ex)) ex_sig
(
    .clk,
    .load,
    .clear,
    .in(ex_sig_in),
    .out(ex_sig_out)
);

register_with_clear #($bits(lc3b_control_word_mem)) mem_sig
(
    .clk,
    .load,
    .clear,
    .in(mem_sig_in),
    .out(mem_sig_out)
);

register_with_clear #($bits(lc3b_control_word_wb)) wb_sig
(
    .clk,
    .load,
    .clear,
    .in(wb_sig_in),
    .out(wb_sig_out)
);

register_with_clear #(3) dest_ex
(
    .clk,
    .load,
    .clear,
    .in(dest_EX_in),
    .out(dest_EX_out)
);

register_with_clear pc_ex
(
    .clk,
    .load,
    .clear,
    .in(pc_EX_in),
    .out(pc_EX_out)
);

register_with_clear #(3) src1_ex
(
    .clk,
    .load,
    .clear,
    .in(src1_EX_in),
    .out(src1_EX_out)
);

register_with_clear #(3) src2_ex
(
    .clk,
    .load,
    .clear,
    .in(src2_EX_in),
    .out(src2_EX_out)
);

register_with_clear src1_data_reg
(
    .clk,
    .load,
    .clear,
    .in(src1_data_in),
    .out(src1_data_EX)
);

register_with_clear src2_data_reg
(
    .clk,
    .load,
    .clear,
    .in(src2_data_in),
    .out(src2_data_EX)
);

/* IR[10:0] */
ir_ex_reg ir_ex_reg_inst
(
    .clk, .load, .clear, .in(ir_10_0_in),
    .imm4(imm4_EX), .imm5(imm5_EX),
    .offset6(offset6_EX), .trapVect8(trapVect8_EX),
    .offset11(offset11_EX_out)
);

endmodule : id_ex
