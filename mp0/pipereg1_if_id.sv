import lc3b_types::*;

module if_id
(
    input clk, load, clear,

    /* inputs */
    input lc3b_word pc_ID_in,
    input lc3b_word ir_in,
    input prediction_ID_in,

    /* outputs */
    output lc3b_word pc_ID_out,
    output lc3b_opcode opcode,
    output lc3b_reg dest_ID_out, src1, src2,
    output lc3b_ir_10_0 ir_10_0,
    output logic prediction_ID_out
);

register_with_clear pc_id
(
    .clk,
    .load,
    .clear,
    .in(pc_ID_in),
    .out(pc_ID_out)
);

register_with_clear #(.width(1)) prediction
(
    .clk,
    .load,
    .clear,
    .in(prediction_ID_in),
    .out(prediction_ID_out)
);

ir_id_reg ir_id
(
    // inputs
    .clk, .load, .clear, .in(ir_in),

    // outputs
    .opcode(opcode), .dest(dest_ID_out), .src1(src1),
    .src2(src2), .ir_10_0(ir_10_0)
);

endmodule : if_id
