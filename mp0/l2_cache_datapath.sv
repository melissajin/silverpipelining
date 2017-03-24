import lc3b_types::*;

module l2_cache_datapath
(
    input clk,

    /* Control signals */
    input load_lru, lru_in, l2wdata_sel,
    input load_d0, load_v0, load_TD0, d_in0, v_in0,
    input load_d1, load_v1, load_TD1, d_in1, v_in1,
    input [1:0] l2addr_sel,
    output logic lru_out, d_out0, d_out1, hit0, hit1,

    /* CPU signals */
    input lc3b_mem_wmask mem_byte_enable,
    input lc3b_word mem_address, mem_wdata,
    output lc3b_word mem_rdata,

    /* Memory signals */
    input l2_read,
    input lc3b_cacheline l2_rdata,
    output lc3b_word l2_address,
    output lc3b_cacheline l2_wdata
);

/* Internal Signals */
logic v_out0, v_out1;
lc3b_cacheline writelogic_out, data_out0, data_out1, wayselector_out;
lc3b_c_tag tag0, tag1;

assign hit0 = (v_out0 & (mem_address[15:7] == tag0));
assign hit1 = (v_out1 & (mem_address[15:7] == tag1));
assign l2_wdata = wayselector_out;

l2_cache_writelogic writelogic
(
    .l2_read, .mem_byte_enable,
    .offset(mem_address[3:1]), .mem_wdata, .l2_rdata, .cur_cacheline(l2_wdata),
    .output_cacheline(writelogic_out)
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


mux2 #(128) wayselector_mux
(
    .sel(l2wdata_sel),
    .a(data_out0),
    .b(data_out1),
    .f(wayselector_out)
);

mux8 #(16) mem_rdata_mux
(
    .sel(mem_address[3:1]),
    .a(wayselector_out[15:0]),
    .b(wayselector_out[31:16]),
    .c(wayselector_out[47:32]),
    .d(wayselector_out[63:48]),
    .e(wayselector_out[79:64]),
    .f(wayselector_out[95:80]),
    .g(wayselector_out[111:96]),
    .h(wayselector_out[127:112]),
    .y(mem_rdata)
);


mux4 #(16) l2addr_mux
(
    .sel(l2addr_sel),
    .a({mem_address[15:4], 4'h0}),
    .b({tag0, mem_address[6:4], 4'h0}),
    .c({tag1, mem_address[6:4], 4'h0}),
    .d(16'h0000),
    .f(l2_address)
);


endmodule : l2_cache_datapath
