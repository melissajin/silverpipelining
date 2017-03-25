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
    output lc3b_cacheline pmem_wdata                                    // datapath
);

lc3b_L2_ctl cache_ctl;
logic [6:0] lru_cur, lru_set;
logic [2:0] pmemwdata_sel;
logic [3:0] pmemaddr_sel;
lc3b_L2_state cache_state;

l2_cache_control control
(
    .clk,

    /* Control signals */
    // inputs
    .lru_in(lru_cur), .way_state(cache_state),
    // outputs
    .ctl(cache_ctl), .lru_out(lru_set), .pmemwdata_sel, .pmemaddr_sel,


    /* Arbiter signals */
    .mem_read, .mem_write,      // inputs
    .mem_resp,                  // outputs

    /* Memory signals */
    .pmem_resp,                 // inputs
    .pmem_read, .pmem_write     // outputs
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
    .mem_address, .l2_wdata(mem_wdata),              // inputs
    .l2_mem_rdata(mem_rdata),                        // outputs

    /* Memory signals */
    .pmem_read, .pmem_rdata,                         // inputs
    .pmem_address, .pmem_wdata                       // outputs

);

endmodule : l2_cache
