import lc3b_types::*;

module ex_mem
(
    /* control inputs */
    /* control outputs */
    // TODO

    /* data inputs */
    input clk,

    input lc3b_reg dest_MEM_in,
    input lc3b_word pc_MEM_in,
    input lc3b_word mar_MEM_in, mdr_MEM_in,
    input lc3b_offset11 offset11_MEM_in,

    /* data outputs */
    output lc3b_reg dest_MEM_out,
    output lc3b_word pc_MEM_out,
    output lc3b_word mar_MEM_out, mdr_MEM_out,
    output lc3b_offset11 offset11_MEM_out,
);

/* Control Signal Registers */
// TODO


register #(3) dest_mem
(
    .clk,
    .load(1'b1),
    .in(dest_MEM_in),
    .out(dest_MEM_out)
);

register pc_mem
(
    .clk,
    .load(1'b1),
    .in(pc_MEM_in),
    .out(pc_MEM_out)
);

register mar_mem
(
    .clk,
    .load(1'b1),
    .in(mar_MEM_in),
    .out(mar_MEM_out)
);

register mdr_mem
(
    .clk,
    .load(1'b1),
    .in(mdr_MEM_in),
    .out(mdr_MEM_out)
);

register #(11) offset11_mem
(
    .clk,
    .load(1'b1),
    .in(offset11_MEM_in),
    .out(offset11_MEM_out)
);


endmodule : ex_mem
