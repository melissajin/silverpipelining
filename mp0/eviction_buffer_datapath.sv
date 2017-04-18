import lc3b_types::*;

module eviction_buffer_datapath
(
    input clk,

    // control signals
    input load,
    input lc3b_7b_plru lru_in,
    input valid,
    input dirty,
    input [3:0] index,
    input read_src_sel,
    output lc3b_7b_plru lru_out,
    output lc3b_eviction_array_entry d_out [7:0],
    output logic hits [7:0],

    // signals to lower level memory
    input lc3b_word buf_mem_address,
    input lc3b_cacheline buf_mem_wdata,
    output lc3b_cacheline buf_mem_rdata,

    // signals to higher level memory
    input lc3b_cacheline super_mem_rdata,
    input logic super_mem_read,
    output lc3b_word super_mem_address,
    output lc3b_cacheline super_mem_wdata
);

/* Internal connections */
lc3b_cacheline wayselector_out;
lc3b_eviction_array_entry d_in;

assign d_in.valid = valid;
assign d_in.dirty = dirty;
assign d_in.addr = buf_mem_address;
assign d_in.data = buf_mem_wdata;

assign buf_mem_rdata = wayselector_out;
assign super_mem_wdata = wayselector_out;

array_fully_associative data
(
    .clk,
    .write(load),
    .index(index[2:0]),
    .datain(d_in),
    .dataout(d_out)
);

register #(7) lru
(
    .clk,
    .load(load),
    .in(lru_in),
    .out(lru_out)
);

mux8 #(128) wayselector_mux
(
    .sel(index[2:0]),
    .a(d_out[0].data),
    .b(d_out[1].data),
    .c(d_out[2].data),
    .d(d_out[3].data),
    .e(d_out[4].data),
    .f(d_out[5].data),
    .g(d_out[6].data),
    .h(d_out[7].data),
    .y(wayselector_out)
);

mux16 #(16) pmemaddr_mux
(
    .sel(index),
    .a(d_out[0].addr),
    .b(d_out[1].addr),
    .c(d_out[2].addr),
    .d(d_out[3].addr),
    .e(d_out[4].addr),
    .f(d_out[5].addr),
    .g(d_out[6].addr),
    .h(d_out[7].addr)
    .i(buf_mem_address),
    .j(16'h0000),
    .k(16'h0000),
    .l(16'h0000),
    .m(16'h0000),
    .n(16'h0000),
    .o(16'h0000),
    .p(16'h0000),
    .y(super_mem_address)
);

mux2 #(128) read_mux
(
    .sel(read_src_sel),
    .a(wayselector_out),
    .b(super_mem_rdata),
    .y(buf_mem_rdata)
);

assign hits[0] = (d_out[0].valid & (buf_mem_address == d_out[0].addr));
assign hits[1] = (d_out[1].valid & (buf_mem_address == d_out[1].addr));
assign hits[2] = (d_out[2].valid & (buf_mem_address == d_out[2].addr));
assign hits[3] = (d_out[3].valid & (buf_mem_address == d_out[3].addr));
assign hits[4] = (d_out[4].valid & (buf_mem_address == d_out[4].addr));
assign hits[5] = (d_out[5].valid & (buf_mem_address == d_out[5].addr));
assign hits[6] = (d_out[6].valid & (buf_mem_address == d_out[6].addr));
assign hits[7] = (d_out[7].valid & (buf_mem_address == d_out[7].addr));

endmodule : eviction_buffer_datapath
