import lc3b_types::*;

module l2_cache_datapath
(
    input clk,

    /* Control signals */
    input lc3b_L2_ctl ctl,
    input [6:0] lru_in,
    input [2:0] pmemwdata_sel,
    input [3:0] pmemaddr_sel,
    output logic [6:0] lru_out,
    output lc3b_L2_state state,

    /* Arbiter signals */
    input lc3b_word mem_address,
	input lc3b_cacheline l2_wdata,
    output lc3b_cacheline l2_mem_rdata,

    /* Physical Memory signals */
    input pmem_read,
    input lc3b_cacheline pmem_rdata,
    output lc3b_word pmem_address_inter,
    output lc3b_cacheline pmem_wdata_inter
);

/* Internal Signals */
lc3b_cacheline writelogic_out, wayselector_out;

logic v_out0, v_out1, v_out2, v_out3;
logic v_out4, v_out5, v_out6, v_out7;

lc3b_cacheline data_out0, data_out1, data_out2, data_out3;
lc3b_cacheline data_out4, data_out5, data_out6, data_out7;

lc3b_c_tag tag0, tag1, tag2, tag3;
lc3b_c_tag tag4, tag5, tag6, tag7;

l2_cache_writelogic writelogic
(
    .pmem_read,
    .pmem_rdata, .l2_wdata,
    .output_cacheline(writelogic_out)
);

array #(7) lru
(
    .clk,
    .write(ctl.load_lru),
    .index(mem_address[7:5]),
    .datain(lru_in),
    .dataout(lru_out)
);

l2_way way0
(
    .clk,

    /* Way Input Signals */
    .load_d(ctl.way0.load_d), .load_v(ctl.way0.load_v), .load_TD(ctl.way0.load_TD), .index(mem_address[7:5]),
    .d_in(ctl.way0.d_in), .v_in(ctl.way0.v_in), .tag_in(mem_address[15:8]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(state.way0.d_out), .v_out(v_out0), .tag_out(tag0), .data_out(data_out0)
);

l2_way way1
(
    .clk,

    /* Way Input Signals */
    .load_d(ctl.way1.load_d), .load_v(ctl.way1.load_v), .load_TD(ctl.way1.load_TD), .index(mem_address[7:5]),
    .d_in(ctl.way1.d_in), .v_in(ctl.way1.v_in), .tag_in(mem_address[15:8]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(state.way1.d_out), .v_out(v_out1), .tag_out(tag1), .data_out(data_out1)
);

l2_way way2
(
    .clk,

    /* Way Input Signals */
    .load_d(ctl.way2.load_d), .load_v(ctl.way2.load_v), .load_TD(ctl.way2.load_TD), .index(mem_address[7:5]),
    .d_in(ctl.way2.d_in), .v_in(ctl.way2.v_in), .tag_in(mem_address[15:8]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(state.way2.d_out), .v_out(v_out2), .tag_out(tag2), .data_out(data_out2)
);

l2_way way3
(
    .clk,

    /* Way Input Signals */
    .load_d(ctl.way3.load_d), .load_v(ctl.way3.load_v), .load_TD(ctl.way3.load_TD), .index(mem_address[7:5]),
    .d_in(ctl.way3.d_in), .v_in(ctl.way3.v_in), .tag_in(mem_address[15:8]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(state.way3.d_out), .v_out(v_out3), .tag_out(tag3), .data_out(data_out3)
);

l2_way way4
(
    .clk,

    /* Way Input Signals */
    .load_d(ctl.way4.load_d), .load_v(ctl.way4.load_v), .load_TD(ctl.way4.load_TD), .index(mem_address[7:5]),
    .d_in(ctl.way4.d_in), .v_in(ctl.way4.v_in), .tag_in(mem_address[15:8]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(state.way4.d_out), .v_out(v_out4), .tag_out(tag4), .data_out(data_out4)
);

l2_way way5
(
    .clk,

    /* Way Input Signals */
    .load_d(ctl.way5.load_d), .load_v(ctl.way5.load_v), .load_TD(ctl.way5.load_TD), .index(mem_address[7:5]),
    .d_in(ctl.way5.d_in), .v_in(ctl.way5.v_in), .tag_in(mem_address[15:8]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(state.way5.d_out), .v_out(v_out5), .tag_out(tag5), .data_out(data_out5)
);

l2_way way6
(
    .clk,

    /* Way Input Signals */
    .load_d(ctl.way6.load_d), .load_v(ctl.way6.load_v), .load_TD(ctl.way6.load_TD), .index(mem_address[7:5]),
    .d_in(ctl.way6.d_in), .v_in(ctl.way6.v_in), .tag_in(mem_address[15:8]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(state.way6.d_out), .v_out(v_out6), .tag_out(tag6), .data_out(data_out6)
);

l2_way way7
(
    .clk,

    /* Way Input Signals */
    .load_d(ctl.way7.load_d), .load_v(ctl.way7.load_v), .load_TD(ctl.way7.load_TD), .index(mem_address[7:5]),
    .d_in(ctl.way7.d_in), .v_in(ctl.way7.v_in), .tag_in(mem_address[15:8]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(state.way7.d_out), .v_out(v_out7), .tag_out(tag7), .data_out(data_out7)
);

mux8 #($bits(lc3b_cacheline)) wayselector_mux
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
    .a({mem_address[15:5], 5'h0}),
    .b({tag0, mem_address[7:5], 5'h0}),
    .c({tag1, mem_address[7:5], 5'h0}),
    .d({tag2, mem_address[7:5], 5'h0}),
    .e({tag3, mem_address[7:5], 5'h0}),
    .f({tag4, mem_address[7:5], 5'h0}),
    .g({tag5, mem_address[7:5], 5'h0}),
    .h({tag6, mem_address[7:5], 5'h0}),
    .i({tag7, mem_address[7:5], 5'h0}),
    .j(16'h0000),
    .k(16'h0000),
    .l(16'h0000),
    .m(16'h0000),
    .n(16'h0000),
    .o(16'h0000),
    .p(16'h0000),
    .y(pmem_address_inter)
);

assign state.way0.hit = (v_out0 & (mem_address[15:8] == tag0));
assign state.way1.hit = (v_out1 & (mem_address[15:8] == tag1));
assign state.way2.hit = (v_out2 & (mem_address[15:8] == tag2));
assign state.way3.hit = (v_out3 & (mem_address[15:8] == tag3));
assign state.way4.hit = (v_out4 & (mem_address[15:8] == tag4));
assign state.way5.hit = (v_out5 & (mem_address[15:8] == tag5));
assign state.way6.hit = (v_out6 & (mem_address[15:8] == tag6));
assign state.way7.hit = (v_out7 & (mem_address[15:8] == tag7));

assign state.way0.v_out = v_out0;
assign state.way1.v_out = v_out1;
assign state.way2.v_out = v_out2;
assign state.way3.v_out = v_out3;
assign state.way4.v_out = v_out4;
assign state.way5.v_out = v_out5;
assign state.way6.v_out = v_out6;
assign state.way7.v_out = v_out7;

assign pmem_wdata_inter = wayselector_out;
assign l2_mem_rdata = wayselector_out;

endmodule : l2_cache_datapath
