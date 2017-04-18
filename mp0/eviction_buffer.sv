import lc3b_types::*;

module eviction_buffer
(
    input clk,

    input buf_mem_read, buf_mem_write,
    input lc3b_word buf_mem_address,
    input lc3b_cacheline buf_mem_wdata,
    // outputs
    output logic buf_mem_resp,
    output lc3b_cacheline buf_mem_rdata,

    // inputs
    input super_mem_resp,
    input lc3b_cacheline super_mem_rdata,
    // outputs
    output logic super_mem_read, super_mem_write,
    output lc3b_word super_mem_address,
    output lc3b_cacheline super_mem_wdata
);


/* Internal connections */
logic load_d, load_lru, valid, dirty;
lc3b_7b_plru lru_set, lru_cur;
logic [2:0] index_sel;
logic read_src_sel, write_sel;
logic [3:0] smemaddr_sel;
lc3b_eviction_array_entry d_out [7:0];
logic hits [7:0];

eviction_buffer_controller controller
(
    .clk,

    // control signals
    .lru_in(lru_cur), .data_array(d_out), .hits(hits), .load_d(load_d), .load_lru(load_lru), .lru_out(lru_set),
    .valid(valid), .dirty(dirty), .index_sel(index_sel), .read_src_sel(read_src_sel), .write_sel(write_sel), .smemaddr_sel(smemaddr_sel),

    // signals to lower level memory
    .buf_mem_read, .buf_mem_write, .buf_mem_resp,

    // signals to higher level memory
    .super_mem_resp, .super_mem_read, .super_mem_write
);

eviction_buffer_datapath datapath
(
    .clk,

    // control signals
    .load_d(load_d), .load_lru(load_lru), .lru_in(lru_set), .valid(valid), .dirty(dirty), .index_sel(index_sel),
    .read_src_sel(read_src_sel), .write_sel(write_sel), .smemaddr_sel(smemaddr_sel), .lru_out(lru_cur), .d_out(d_out), .hits(hits),

    // signals to lower level memory
    .buf_mem_address, .buf_mem_wdata, .buf_mem_rdata,

    // signals to higher level memory
    .super_mem_address, .super_mem_wdata, .super_mem_rdata
);


endmodule : eviction_buffer
