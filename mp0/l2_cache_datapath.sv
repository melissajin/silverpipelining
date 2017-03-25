import lc3b_types::*;

module l2_cache_datapath
(
    input clk,

    /* Control signals */
    input load_lru, lru_in, pmemwdata_sel,
    input load_d0, load_v0, load_TD0, d_in0, v_in0,
    input load_d1, load_v1, load_TD1, d_in1, v_in1,
    input [1:0] pmemaddr_sel,
    output logic lru_out, d_out0, d_out1,
    output logic hit0, hit1, hit2, hit3, hit4,
    output logic hit5, hit6, hit7,

    /* CPU signals */
    input lc3b_mem_wmask mem_byte_enable,
    input lc3b_word mem_address, mem_wdata,
    output lc3b_word mem_rdata,

    /* Memory signals */
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
assign ____ = wayselector_out;

l2_cache_writelogic writelogic
(
    .pmem_read,
    .pmem_rdata, .l1_wdata,
    .output_cacheline
);


array #(1) lru
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

mux4 #(16) pmemaddr_mux
(
    .sel(pmemaddr_sel),
    .a({mem_address[15:4], 4'h0}),
    .b({tag0, mem_address[6:4], 4'h0}),
    .c({tag1, mem_address[6:4], 4'h0}),
    .d(16'h0000),
    .f(pmem_address)
);

endmodule : l2_cache_datapath
