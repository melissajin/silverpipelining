import lc3b_types::*;

module mem_wb
(
    input clk, load,

    /* control inputs */
    input lc3b_control_word_wb wb_sig_in,

    /* control outputs */
    output lc3b_control_word_wb wb_sig_out,

    /* data inputs */
    input lc3b_reg dest_WB_in,
    input lc3b_word pc_WB_in, alu_WB_in,
    input lc3b_word pcp_off_WB_in,
    input lc3b_word mdr_WB_in,
    input logic mar_wb_lsb_in,

    /* data outputs */
    output lc3b_reg dest_WB_out,
    output lc3b_word pc_WB_out, alu_WB_out,
    output lc3b_word pcp_off_WB_out,
    output lc3b_word mdr_WB_out,
    output logic mar_wb_lsb_out
);

/* Control Signal Registers */
register #($bits(lc3b_control_word_wb)) wb_sig
(
    .clk,
    .load,
    .in(wb_sig_in),
    .out(wb_sig_out)
);

register #(3) dest_wb
(
    .clk,
    .load,
    .in(dest_WB_in),
    .out(dest_WB_out)
);

register alu_wb
(
    .clk,
    .load,
    .in(alu_WB_in),
    .out(alu_WB_out)
);

register pc_wb
(
    .clk,
    .load,
    .in(pc_WB_in),
    .out(pc_WB_out)
);

register pc_plus_off_wb
(
    .clk,
    .load,
    .in(pcp_off_WB_in),
    .out(pcp_off_WB_out)
);

register mdr_wb
(
    .clk,
    .load,
    .in(mdr_WB_in),
    .out(mdr_WB_out)
);

register #(1) mar_wb_lsb
(
    .clk,
    .load,
    .in(mar_wb_lsb_in),
    .out(mar_wb_lsb_out)
);

endmodule : mem_wb
