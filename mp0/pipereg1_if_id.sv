import lc3b_types::*;

module if_id
(
    input clk, load,

    /* inputs */
    input lc3b_word pc_ID_in,
    input lc3b_word ir_in,

    /* outputs */
    output lc3b_word pc_ID_out,
    output lc3b_opcode opcode,
    output lc3b_reg dest_ID_out, src1, src2,
    output lc3b_ir_10_0 ir_10_0,
    output logic init_ID_out
);

register pc_id
(
    .clk,
    .load,
    .in(pc_ID_in),
    .out(pc_ID_out)
);

ir_id_reg ir_id
(
    // inputs
    .clk, .load, .in(ir_in),

    // outputs
    .opcode(opcode), .dest(dest_ID_out), .src1(src1),
    .src2(src2), .ir_10_0(ir_10_0)
);

register #(1) init_id
(
    .clk,
    .load(1'b1),
    .in(1'b1),
    .out(init_ID_out)
);

endmodule : if_id
