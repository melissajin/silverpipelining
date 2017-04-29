import lc3b_types::*;

module l2_cache
(
    input clk,

    /******* Signals between Arbiter and L2 Cache *******/
    input mem_read, mem_write,
    input lc3b_word mem_address,
    input lc3b_cacheline mem_wdata,
    output logic mem_resp,
    output lc3b_cacheline mem_rdata,

    /******* Signals between L2 Cache and Physical Memory *******/
    input pmem_resp,
    input lc3b_cacheline pmem_rdata,
    output logic pmem_read, pmem_write,
    output lc3b_word pmem_address,
    output lc3b_cacheline pmem_wdata,
    output logic eviction,
    
    /* Performance counter signals */
    output logic l2hits_inc, l2misses_inc
);

lc3b_L2_ctl cache_ctl;
logic [6:0] lru_cur, lru_set;
logic [2:0] pmemwdata_sel;
logic [3:0] pmemaddr_sel;
lc3b_L2_state cache_state;

lc3b_word pmem_address_inter;
lc3b_cacheline pmem_wdata_inter;

logic mem_read_sync, mem_write_sync;
lc3b_word mem_address_sync;
lc3b_cacheline mem_wdata_sync;

l2_cache_control control
(
    .clk,

    /* Control signals */
    .lru_in(lru_cur), .way_state(cache_state),
    .ctl(cache_ctl), .lru_out(lru_set), .pmemwdata_sel, .pmemaddr_sel,


    /* Arbiter signals */
    .mem_read(mem_read_sync), .mem_write(mem_write_sync),
    .mem_resp,

    /* Memory signals */
    .pmem_resp, .pmem_address_inter, .pmem_wdata_inter,
    .pmem_read, .pmem_write, .pmem_address, .pmem_wdata,
    .eviction,
    
    /******* Performance counter signals *******/
    .l2hits_inc, .l2misses_inc
);

l2_cache_datapath datapath
(
    .clk,

    /* Control signals */
    // inputs
    .ctl(cache_ctl), .lru_in(lru_set), .pmemwdata_sel, .pmemaddr_sel,
    // outputs
    .lru_out(lru_cur), .state(cache_state),

    /* Arbiter signals */
    .mem_address(mem_address_sync), .l2_wdata(mem_wdata_sync),
    .l2_mem_rdata(mem_rdata),

    /* Memory signals */
    .pmem_read, .pmem_rdata,
    .pmem_address_inter, .pmem_wdata_inter

);

// Synchronization between Arbiter and L2 cache
always_ff @ (posedge clk) begin
    mem_read_sync = mem_read;
    mem_write_sync = mem_write;
    mem_address_sync = mem_address;
    mem_wdata_sync = mem_wdata;
end

endmodule : l2_cache
