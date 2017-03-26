import lc3b_types::*;

module l2_cache_datapath
(
    input clk,

    /* Control signals */
    input lc3b_L2_ctl ctl,
    input lc3b_l2_lru lru_in,
    input [1:0] pmemwdata_sel,
    input [2:0] pmemaddr_sel,
    output lc3b_l2_lru lru_out,
    output lc3b_L2_state state,

    /* Arbiter signals */
    input lc3b_word mem_address,
	 input lc3b_cacheline l2_wdata,
    output lc3b_cacheline l2_mem_rdata,

    /* Physical Memory signals */
    input pmem_read,
    input lc3b_cacheline pmem_rdata,
    output lc3b_word pmem_address,
    output lc3b_cacheline pmem_wdata
);

/* Internal Signals */
lc3b_cacheline writelogic_out, wayselector_out;

logic v_out0, v_out1, v_out2, v_out3;

lc3b_cacheline data_out0, data_out1, data_out2, data_out3;

lc3b_c_tag tag0, tag1, tag2, tag3;

l2_cache_writelogic writelogic
(
    .pmem_read,
    .pmem_rdata, .l2_wdata,
    .output_cacheline(writelogic_out)
);

array #(3) lru
(
    .clk,
    .write(ctl.load_lru),
    .index(mem_address[6:4]),
    .datain(lru_in),
    .dataout(lru_out)
);

l2_way way0
(
    .clk,

    /* Way Input Signals */
    .load_d(ctl.way0.load_d), .load_v(ctl.way0.load_v), .load_TD(ctl.way0.load_TD), .index(mem_address[6:4]),
    .d_in(ctl.way0.d_in), .v_in(ctl.way0.v_in), .tag_in(mem_address[15:7]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(state.way0.d_out), .v_out(v_out0), .tag_out(tag0), .data_out(data_out0)
);

l2_way way1
(
    .clk,

    /* Way Input Signals */
    .load_d(ctl.way1.load_d), .load_v(ctl.way1.load_v), .load_TD(ctl.way1.load_TD), .index(mem_address[6:4]),
    .d_in(ctl.way1.d_in), .v_in(ctl.way1.v_in), .tag_in(mem_address[15:7]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(state.way1.d_out), .v_out(v_out1), .tag_out(tag1), .data_out(data_out1)
);

l2_way way2
(
    .clk,

    /* Way Input Signals */
    .load_d(ctl.way2.load_d), .load_v(ctl.way2.load_v), .load_TD(ctl.way2.load_TD), .index(mem_address[6:4]),
    .d_in(ctl.way2.d_in), .v_in(ctl.way2.v_in), .tag_in(mem_address[15:7]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(state.way2.d_out), .v_out(v_out2), .tag_out(tag2), .data_out(data_out2)
);

l2_way way3
(
    .clk,

    /* Way Input Signals */
    .load_d(ctl.way3.load_d), .load_v(ctl.way3.load_v), .load_TD(ctl.way3.load_TD), .index(mem_address[6:4]),
    .d_in(ctl.way3.d_in), .v_in(ctl.way3.v_in), .tag_in(mem_address[15:7]), .data_in(writelogic_out),

    /* Way Output Signals */
    .d_out(state.way3.d_out), .v_out(v_out3), .tag_out(tag3), .data_out(data_out3)
);

mux4 #(128) wayselector_mux
(
    .sel(pmemwdata_sel),
    .a(data_out0),
    .b(data_out1),
    .c(data_out2),
    .d(data_out3),
    .f(wayselector_out)
);

mux8 #(16) pmemaddr_mux
(
    .sel(pmemaddr_sel),
    .a({mem_address[15:4], 4'h0}),
    .b({tag0, mem_address[6:4], 4'h0}),
    .c({tag1, mem_address[6:4], 4'h0}),
    .d({tag2, mem_address[6:4], 4'h0}),
    .e({tag3, mem_address[6:4], 4'h0}),
    .f(16'h0000),
    .g(16'h0000),
    .h(16'h0000),
    .y(pmem_address)
);

assign state.way0.hit = (v_out0 & (mem_address[15:7] == tag0));
assign state.way1.hit = (v_out1 & (mem_address[15:7] == tag1));
assign state.way2.hit = (v_out2 & (mem_address[15:7] == tag2));
assign state.way3.hit = (v_out3 & (mem_address[15:7] == tag3));

assign pmem_wdata = wayselector_out;
assign l2_mem_rdata = wayselector_out;

endmodule : l2_cache_datapath
