import lc3b_types::*;

module ex_mem
(
    input clk, load, clear,

    /* control inputs */
    input lc3b_control_word_mem mem_sig_in,
    input lc3b_control_word_wb wb_sig_in,

    /* control outputs */
    output lc3b_control_word_mem mem_sig_out,
    output lc3b_control_word_wb wb_sig_out,

    /* data inputs */
    input lc3b_reg dest_MEM_in,
    input lc3b_reg src1_MEM_in,
    input lc3b_reg src2_MEM_in,
    input lc3b_word pc_MEM_in, alu_MEM_in,
    input lc3b_word pcp_off_MEM_in,
    input lc3b_word mar_MEM_in, mdr_MEM_in,
    input lc3b_offset11 offset11_MEM_in,
    input logic [1:0] mem_byte_enable_in,

    /* data outputs */
    output lc3b_reg dest_MEM_out,
    output lc3b_reg src1_MEM_out,
    output lc3b_reg src2_MEM_out,
    output lc3b_word pc_MEM_out, alu_MEM_out,
    output lc3b_word pcp_off_MEM_out,
    output lc3b_word mar_MEM_out, mdr_MEM_out,
    output lc3b_offset11 offset11_MEM_out,
    output logic [1:0] mem_byte_enable_out
);

/* Control Signal Registers */
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


register_with_clear #(3) dest_mem
(
    .clk,
    .load,
    .clear,
    .in(dest_MEM_in),
    .out(dest_MEM_out)
);

register_with_clear #(3) src1_mem
(
    .clk,
    .load,
    .clear,
    .in(src1_MEM_in),
    .out(src1_MEM_out)
);

register_with_clear #(3) src2_mem
(
    .clk,
    .load,
    .clear,
    .in(src2_MEM_in),
    .out(src2_MEM_out)
);

register_with_clear alu_mem
(
    .clk,
    .load,
    .clear,
    .in(alu_MEM_in),
    .out(alu_MEM_out)
);

register_with_clear pc_mem
(
    .clk,
    .load,
    .clear,
    .in(pc_MEM_in),
    .out(pc_MEM_out)
);

register_with_clear pc_plus_off_mem
(
    .clk,
    .load,
    .clear,
    .in(pcp_off_MEM_in),
    .out(pcp_off_MEM_out)
);

register_with_clear #(11) offset11_mem
(
    .clk,
    .load,
    .clear,
    .in(offset11_MEM_in),
    .out(offset11_MEM_out)
);

register_with_clear mar_mem
(
    .clk,
    .load,
    .clear,
    .in(mar_MEM_in),
    .out(mar_MEM_out)
);

register_with_clear mdr_mem
(
    .clk,
    .load,
    .clear,
    .in(mdr_MEM_in),
    .out(mdr_MEM_out)
);

register_with_clear #(2) mem_byte_enable
(
    .clk,
    .load,
    .clear,
    .in(mem_byte_enable_in),
    .out(mem_byte_enable_out)
);

endmodule : ex_mem
