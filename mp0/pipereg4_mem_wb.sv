import lc3b_types::*;

module mem_wb
(
    /* control inputs */
    input lc3b_control_word_wb wb_sig_in;

    /* control outputs */
    output lc3b_control_word_wb wb_sig_out;

    /* data inputs */
    input clk,

    input lc3b_reg dest_WB_in,
    input lc3b_word pc_WB_in,
    input lc3b_word mdr_WB_in,
    input lc3b_offset11 offset11_WB_in,

    /* data outputs */
    output lc3b_reg dest_WB_out,
    output lc3b_word pc_WB_out,
    output lc3b_word mdr_WB_out,
    output lc3b_offset9 offset9_WB_out,
    output lc3b_offset11 offset11_WB_out
);

assign offset9_WB_out = offset11_WB_out[8:0];

/* Control Signal Registers */
// TODO


register #(3) dest_wb
(
    .clk,
    .load(1'b1),
    .in(dest_WB_in),
    .out(dest_WB_out)
);

register pc_wb
(
    .clk,
    .load(1'b1),
    .in(pc_WB_in),
    .out(pc_WB_out)
);

register mdr_wb
(
    .clk,
    .load(1'b1),
    .in(mdr_WB_in),
    .out(mdr_WB_out)
);

register #(11) offset11_wb
(
    .clk,
    .load(1'b1),
    .in(offset11_WB_in),
    .out(offset11_WB_out)
);


endmodule : mem_wb
