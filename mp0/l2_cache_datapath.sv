import lc3b_types::*;

module l2_cache_datapath
(
    input clk,

    /* Control signals */
    input load_lru,
    input [6:0] lru_in,
    input [2:0] pmemwdata_sel,
    input [3:0] pmemaddr_sel,
    input load_d0, load_v0, load_TD0, d_in0, v_in0,
    input load_d1, load_v1, load_TD1, d_in1, v_in1,
    input load_d2, load_v2, load_TD2, d_in2, v_in2,
    input load_d3, load_v3, load_TD3, d_in3, v_in3,
    input load_d4, load_v4, load_TD4, d_in4, v_in4,
    input load_d5, load_v5, load_TD5, d_in5, v_in5,
    input load_d6, load_v6, load_TD6, d_in6, v_in6,
    input load_d7, load_v7, load_TD7, d_in7, v_in7,
    output logic [6:0] lru_out,
    output logic d_out0, d_out1, d_out2, d_out3,
    output logic d_out4, d_out5, d_out6, d_out7,
    output logic hit0, hit1, hit2, hit3,
    output logic hit4, hit5, hit6, hit7,

    /* Arbiter signals */
    input lc3b_word mem_address, l2_wdata,
    output lc3b_word l2_mem_rdata,

    /* Physical Memory signals */
    input pmem_read,
    input lc3b_cacheline pmem_rdata,
    output lc3b_word pmem_address,
    output lc3b_cacheline pmem_wdata
);

/* Internal Signals */
lc3b_cacheline writelogic_out, wayselector_out;

logic v_out0, v_out1, v_out2, v_out3;
logic v_out4, v_out5, v_out6, v_out7;

lc3b_cacheline data_out0, data_out1, data_out2, data_out3;
lc3b_cacheline data_out4, data_out5, data_out6, data_out7;

lc3b_c_tag tag0, tag1, tag2, tag3;
lc3b_c_tag tag4, tag5, tag6, tag7;

assign hit0 = (v_out0 & (mem_address[15:7] == tag0));
assign hit1 = (v_out1 & (mem_address[15:7] == tag1));
assign hit2 = (v_out2 & (mem_address[15:7] == tag2));
assign hit3 = (v_out3 & (mem_address[15:7] == tag3));
assign hit4 = (v_out4 & (mem_address[15:7] == tag4));
assign hit5 = (v_out5 & (mem_address[15:7] == tag5));
assign hit6 = (v_out6 & (mem_address[15:7] == tag6));
assign hit7 = (v_out7 & (mem_address[15:7] == tag7));

assign pmem_wdata = wayselector_out;
assign l2_mem_rdata = wayselector_out;

l2_cache_writelogic writelogic
(
    .pmem_read,
    .pmem_rdata, .l2_wdata,
    .output_cacheline(writelogic_out)
);

array #(7) lru
(
    .clk,
    .write(load_lru),
    .index(mem_address[6:4]),
    .datain(lru_in),
    .dataout(lru_out)
);

l2_way way0
(
    .clk,

    /* Way Input Signals */
    .load_d(load_d0), .load_v(load_v0), .load_TD(load_TD0), .index(mem_address[6:4]),
    .d_in(d_in0), .v_in(v_in0), .tag_in(mem_address[15:7]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(d_out0), .v_out(v_out0), .tag_out(tag0), .data_out(data_out0)
);

l2_way way1
(
    .clk,

    /* Way Input Signals */
    .load_d(load_d1), .load_v(load_v1), .load_TD(load_TD1), .index(mem_address[6:4]),
    .d_in(d_in1), .v_in(v_in1), .tag_in(mem_address[15:7]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(d_out1), .v_out(v_out1), .tag_out(tag1), .data_out(data_out1)
);

l2_way way2
(
    .clk,

    /* Way Input Signals */
    .load_d(load_d2), .load_v(load_v2), .load_TD(load_TD2), .index(mem_address[6:4]),
    .d_in(d_in2), .v_in(v_in2), .tag_in(mem_address[15:7]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(d_out2), .v_out(v_out2), .tag_out(tag2), .data_out(data_out2)
);

l2_way way3
(
    .clk,

    /* Way Input Signals */
    .load_d(load_d3), .load_v(load_v3), .load_TD(load_TD3), .index(mem_address[6:4]),
    .d_in(d_in3), .v_in(v_in3), .tag_in(mem_address[15:7]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(d_out3), .v_out(v_out3), .tag_out(tag3), .data_out(data_out3)
);

l2_way way4
(
    .clk,

    /* Way Input Signals */
    .load_d(load_d4), .load_v(load_v4), .load_TD(load_TD4), .index(mem_address[6:4]),
    .d_in(d_in4), .v_in(v_in4), .tag_in(mem_address[15:7]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(d_out4), .v_out(v_out4), .tag_out(tag4), .data_out(data_out4)
);

l2_way way5
(
    .clk,

    /* Way Input Signals */
    .load_d(load_d5), .load_v(load_v5), .load_TD(load_TD5), .index(mem_address[6:4]),
    .d_in(d_in5), .v_in(v_in5), .tag_in(mem_address[15:7]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(d_out5), .v_out(v_out5), .tag_out(tag5), .data_out(data_out5)
);

l2_way way6
(
    .clk,

    /* Way Input Signals */
    .load_d(load_d6), .load_v(load_v6), .load_TD(load_TD6), .index(mem_address[6:4]),
    .d_in(d_in6), .v_in(v_in6), .tag_in(mem_address[15:7]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(d_out6), .v_out(v_out6), .tag_out(tag6), .data_out(data_out6)
);

l2_way way7
(
    .clk,

    /* Way Input Signals */
    .load_d(load_d7), .load_v(load_v7), .load_TD(load_TD7), .index(mem_address[6:4]),
    .d_in(d_in7), .v_in(v_in7), .tag_in(mem_address[15:7]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(d_out7), .v_out(v_out7), .tag_out(tag7), .data_out(data_out7)
);

mux8 #(128) wayselector_mux
(
    .sel(pmemwdata_sel),
    .a(data_out0),
    .b(data_out1),
    .c(data_out2),
    .d(data_out3),
    .e(data_out4),
    .f(data_out5),
    .g(data_out6),
    .h(data_out7),
    .y(wayselector_out)
);

mux16 #(16) pmemaddr_mux
(
    .sel(pmemaddr_sel),
    .a({mem_address[15:4], 4'h0}),
    .b({tag0, mem_address[6:4], 4'h0}),
    .c({tag1, mem_address[6:4], 4'h0}),
    .d({tag2, mem_address[6:4], 4'h0}),
    .e({tag3, mem_address[6:4], 4'h0}),
    .f({tag4, mem_address[6:4], 4'h0}),
    .g({tag5, mem_address[6:4], 4'h0}),
    .h({tag6, mem_address[6:4], 4'h0}),
    .i({tag7, mem_address[6:4], 4'h0}),
    .j(16'h0000),
    .k(16'h0000),
    .l(16'h0000),
    .m(16'h0000),
    .n(16'h0000),
    .o(16'h0000),
    .p(16'h0000),
    .y(pmem_address)
);

endmodule : l2_cache_datapath
