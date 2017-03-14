import lc3b_types::*;

module ex_mem
(
    input clk, load,

    /* control inputs */
    input lc3b_control_word_mem mem_sig_in,
    input lc3b_control_word_wb wb_sig_in,

    /* control outputs */
    output lc3b_control_word_mem mem_sig_out,
    output lc3b_control_word_wb wb_sig_out,

    /* data inputs */
    input lc3b_reg dest_MEM_in,
    input lc3b_word pc_MEM_in, alu_MEM_in,
    input lc3b_word mar_MEM_in, mdr_MEM_in,
    input lc3b_offset11 offset11_MEM_in,
    input logic init_MEM_in,

    /* data outputs */
    output lc3b_reg dest_MEM_out,
    output lc3b_word pc_MEM_out, alu_MEM_out,
    output lc3b_word mar_MEM_out, mdr_MEM_out,
    output lc3b_offset11 offset11_MEM_out,
    output logic init_MEM_out
);

/* Control Signal Registers */
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


register #(3) dest_mem
(
    .clk,
    .load,
    .in(dest_MEM_in),
    .out(dest_MEM_out)
);

register alu_mem
(
    .clk,
    .load,
    .in(alu_MEM_in),
    .out(alu_MEM_out)
);

register pc_mem
(
    .clk,
    .load,
    .in(pc_MEM_in),
    .out(pc_MEM_out)
);

register mar_mem
(
    .clk,
    .load,
    .in(mar_MEM_in),
    .out(mar_MEM_out)
);

register mdr_mem
(
    .clk,
    .load,
    .in(mdr_MEM_in),
    .out(mdr_MEM_out)
);

register #(11) offset11_mem
(
    .clk,
    .load,
    .in(offset11_MEM_in),
    .out(offset11_MEM_out)
);

register #(1) init_mem
(
    .clk,
    .load(1'b1),
    .in(init_MEM_in),
    .out(init_MEM_out)
);

endmodule : ex_mem
