import lc3b_types::*;

module mem_wb
(
    input clk, load, clear,

    /* control inputs */
    input lc3b_control_word_wb wb_sig_in,

    /* control outputs */
    output lc3b_control_word_wb wb_sig_out,

    /* data inputs */
    input lc3b_reg dest_WB_in,
    input lc3b_word pc_WB_in, alu_WB_in,
    input lc3b_word pcp_off_WB_in,
    input lc3b_word mdr_WB_in,
    input lc3b_word mar_WB_in,
    input prediction_WB_in,

    /* data outputs */
    output lc3b_reg dest_WB_out,
    output lc3b_word pc_WB_out, alu_WB_out,
    output lc3b_word pcp_off_WB_out,
    output lc3b_word mdr_WB_out,
    output lc3b_word mar_WB_out,
    output logic prediction_WB_out
);

register_with_clear #(.width(1)) prediction
(
    .clk,
    .load,
    .clear,
    .in(prediction_WB_in),
    .out(prediction_WB_out)
);

/* Control Signal Registers */
register_with_clear #($bits(lc3b_control_word_wb)) wb_sig
(
    .clk,
    .load,
    .clear,
    .in(wb_sig_in),
    .out(wb_sig_out)
);

register_with_clear #(3) dest_wb
(
    .clk,
    .load,
    .clear,
    .in(dest_WB_in),
    .out(dest_WB_out)
);

register_with_clear alu_wb
(
    .clk,
    .load,
    .clear,
    .in(alu_WB_in),
    .out(alu_WB_out)
);

register_with_clear pc_wb
(
    .clk,
    .load,
    .clear,
    .in(pc_WB_in),
    .out(pc_WB_out)
);

register_with_clear pc_plus_off_wb
(
    .clk,
    .load,
    .clear,
    .in(pcp_off_WB_in),
    .out(pcp_off_WB_out)
);

register_with_clear mdr_wb
(
    .clk,
    .load,
    .clear,
    .in(mdr_WB_in),
    .out(mdr_WB_out)
);

register_with_clear mar_wb
(
    .clk,
    .load,
    .clear,
    .in(mar_WB_in),
    .out(mar_WB_out)
);

endmodule : mem_wb
