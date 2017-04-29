import lc3b_types::*;

module hardware_prefetcher_datapath
(
    input clk,

    /***** Control Signals *****/
    input load_pf_line, load_pf_addr, i_rdata_sel, l2_address_sel,
    output lc3b_word prefetch_addr_out,
    output logic valid,

    /***** I-Cache Signals *****/
    input lc3b_word i_address,
    output lc3b_cacheline i_rdata,

    /***** L2 Arbiter Signals *****/
    input lc3b_cacheline l2_rdata,
    input l2_read,
    output lc3b_word l2_address
);

lc3b_word prefetch_addr_in;
assign prefetch_addr_in = i_address + 16'h0020;

lc3b_cacheline prefetch_line_out;

register #(1) validity
(
    .clk,
    .load(l2_read),
    .in(1'b1),
    .out(valid)
);

register #($bits(lc3b_word)) prefetch_address
(
    .clk,
    .load(load_pf_addr),
    .in(prefetch_addr_in),
    .out(prefetch_addr_out)
);

register #($bits(lc3b_cacheline)) prefetch_line
(
    .clk,
    .load(load_pf_line),
    .in(l2_rdata),
    .out(prefetch_line_out)
);

mux2 #($bits(lc3b_cacheline)) i_rdata_mux
(
    .sel(i_rdata_sel),
    .a(l2_rdata),
    .b(prefetch_line_out),
    .f(i_rdata)
);

mux2 #($bits(lc3b_word)) l2_address_mux
(
    .sel(l2_address_sel),
    .a(i_address),
    .b(prefetch_addr_out),
    .f(l2_address)
);

endmodule : hardware_prefetcher_datapath
