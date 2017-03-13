import lc3b_types::*;

module mem_wb
(
    /* control inputs */
    /* control outputs */
    // TODO

    /* data inputs */
    input clk,

    input lc3b_reg dest_WB_in,
    input lc3b_word mdr_WB_in,

    /* data outputs */
    output lc3b_reg dest_WB_out,
    output lc3b_word mdr_WB_out,
);

/* Control Signal Registers */
// TODO


register #(3) dest_wb
(
    .clk,
    .load(1'b1),
    .in(dest_WB_in),
    .out(dest_WB_out)
);

register mdr_wb
(
    .clk,
    .load(1'b1),
    .in(mdr_WB_in),
    .out(mdr_WB_out)
);


endmodule : mem_wb
