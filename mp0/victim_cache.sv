import lc3b_types::*;

module victim_cache
(
    input clk,

    // inputs
    input eviction,
    input buf_mem_read, buf_mem_write,
    input lc3b_word buf_mem_address,
    input lc3b_cacheline buf_mem_wdata,
    // outputs
    output logic buf_mem_resp,
    output lc3b_cacheline buf_mem_rdata,

    // inputs
    input s_mem_resp,
    input lc3b_cacheline s_mem_rdata,
    // outputs
    output logic s_mem_read, s_mem_write,
    output lc3b_word s_mem_address,
    output lc3b_cacheline s_mem_wdata
);


/* Internal connections */
logic load_d, load_lru, valid, dirty;
lc3b_7b_plru lru_set, lru_cur;
logic [2:0] index_sel;
logic read_src_sel, write_sel;
logic [3:0] smemaddr_sel;
lc3b_eviction_array_entry d_out [7:0];
logic hits [7:0];

victim_cache_controller controller
(
    .clk,

    // control signals
    .lru_in(lru_cur), .data_array(d_out), .hits(hits), .load_d(load_d), .load_lru(load_lru), .lru_out(lru_set),
    .valid(valid), .dirty(dirty), .index_sel(index_sel), .read_src_sel(read_src_sel), .write_sel(write_sel), .smemaddr_sel(smemaddr_sel),

    // signals to lower level memory
    .eviction,
    .buf_mem_read, .buf_mem_write, .buf_mem_resp,

    // signals to higher level memory
    .s_mem_resp, .s_mem_read, .s_mem_write
);

victim_cache_datapath datapath
(
    .clk,

    // control signals
    .load_d(load_d), .load_lru(load_lru), .lru_in(lru_set), .valid(valid), .dirty(dirty), .index_sel(index_sel),
    .read_src_sel(read_src_sel), .write_sel(write_sel), .smemaddr_sel(smemaddr_sel), .lru_out(lru_cur), .d_out(d_out), .hits(hits),

    // signals to lower level memory
    .buf_mem_address, .buf_mem_wdata, .buf_mem_rdata,

    // signals to higher level memory
    .s_mem_address, .s_mem_wdata, .s_mem_rdata
);


endmodule : victim_cache
