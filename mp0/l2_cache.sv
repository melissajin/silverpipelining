import lc3b_types::*;

module l2_cache
(
    input clk,

    /******* Signals between Arbiter and L2 Cache *******/
    // inputs
    input mem_read, mem_write,                                          // control
    input lc3b_word mem_address,
    input lc3b_cacheline mem_wdata,                             // datapath
    // outputs
    output logic mem_resp,                                              // control
    output lc3b_cacheline mem_rdata,                                         // datapath

    /******* Signals between L2 Cache and Physical Memory *******/
    // inputs
    input pmem_resp,                                                    // control
    input lc3b_cacheline pmem_rdata,                                    // datapath
    // outputs
    output logic pmem_read, pmem_write,                                   // control
    output lc3b_word pmem_address,                                      // datapath
    output lc3b_cacheline pmem_wdata,                                    // datapath

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
    // inputs
    .lru_in(lru_cur), .way_state(cache_state),
    // outputs
    .ctl(cache_ctl), .lru_out(lru_set), .pmemwdata_sel, .pmemaddr_sel,


    /* Arbiter signals */
    .mem_read(mem_read_sync), .mem_write(mem_write_sync),      // inputs
    .mem_resp,                  // outputs

    /* Memory signals */
    .pmem_resp, .pmem_address_inter, .pmem_wdata_inter,    // inputs
    .pmem_read, .pmem_write, .pmem_address, .pmem_wdata,    // outputs

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
    .mem_address(mem_address_sync), .l2_wdata(mem_wdata_sync),              // inputs
    .l2_mem_rdata(mem_rdata),                        // outputs

    /* Memory signals */
    .pmem_read, .pmem_rdata,                         // inputs
    .pmem_address_inter, .pmem_wdata_inter           // outputs

);

// Synchronization between Arbiter and L2 cache
register #(.width(1)) mem_read_reg
(
    .clk,
    .load(1'b1),
    .in(mem_read),
    .out(mem_read_sync)
);

register #(.width(1)) mem_write_reg
(
    .clk,
    .load(1'b1),
    .in(mem_write),
    .out(mem_write_sync)
);

register #(.width(16)) mem_address_reg
(
    .clk,
    .load(1'b1),
    .in(mem_address),
    .out(mem_address_sync)
);

register #(.width(128)) mem_wdata_reg
(
    .clk,
    .load(1'b1),
    .in(mem_wdata),
    .out(mem_wdata_sync)
);


endmodule : l2_cache
