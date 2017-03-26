import lc3b_types::*;

module l2_way
(
    input clk,

    /* Way Input Signals */
    input load_d, load_v, load_TD,
    input lc3b_l2_index index,
    input d_in, v_in,
    input lc3b_l2_tag tag_in,
    input lc3b_cacheline data_in,

    /* Way Output Signals */
    output logic d_out, v_out,
    output lc3b_l2_tag tag_out,
    output lc3b_cacheline data_out
);

l2_array #(1) dirty
(
    .clk,
    .write(load_d),
    .index,
    .datain(d_in),
    .dataout(d_out)
);

l2_array #(1) valid
(
    .clk,
    .write(load_v),
    .index,
    .datain(v_in),
    .dataout(v_out)
);

l2_array #(8) tag
(
    .clk,
    .write(load_TD),
    .index,
    .datain(tag_in),
    .dataout(tag_out)
);

l2_array #(128) data
(
    .clk,
    .write(load_TD),
    .index,
    .datain(data_in),
    .dataout(data_out)
);

endmodule : l2_way
