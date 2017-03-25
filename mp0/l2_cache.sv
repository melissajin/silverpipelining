import lc3b_types::*;

module l2_cache
(
    input clk,

    /******* Signals between CPU and Cache *******/
    // inputs
    input mem_read, mem_write,                                          // control
    input lc3b_mem_wmask mem_byte_enable,                               // datapath
    input lc3b_word mem_address, mem_wdata,                             // datapath
    // outputs
    output logic mem_resp,                                              // control
    output lc3b_word mem_rdata,                                         // datapath

    /******* Signals between Cache and Physical Memory *******/
    // inputs
    input pmem_resp,                                                    // control
    input lc3b_cacheline pmem_rdata,                                    // datapath
    // outputs
    output logic pmem_read, pmem_write,                                   // control
    output lc3b_word pmem_address,                                      // datapath
    output lc3b_cacheline pmem_wdata                                    // datapath
);

logic load_lru, pmemwdata_sel;
logic load_d0, load_v0, load_TD0, d_set0, v_set0;
logic load_d1, load_v1, load_TD1, d_set1, v_set1;
logic [1:0] pmemaddr_sel;
logic lru, lru_set, dirty0, dirty1, hit0, hit1;

l2_cache_control control
(
    .clk,

    /* Datapath controls */
    // inputs
    .lru_in(lru), .d_in0(dirty0), .d_in1(dirty1), .hit0, .hit1,
    // outputs
    .load_lru, .lru_set, .pmemwdata_sel,
    .load_d0, .load_v0, .load_TD0, .d_set0(d_set0), .v_set0(v_set0),
    .load_d1, .load_v1, .load_TD1, .d_set1(d_set1), .v_set1(v_set1),
    .pmemaddr_sel,

    /* CPU signals */
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
    .load_lru, .lru_in(lru_set), .pmemwdata_sel,
    .load_d0, .load_v0, .load_TD0, .d_in0(d_set0), .v_in0(v_set0),
    .load_d1, .load_v1, .load_TD1, .d_in1(d_set1), .v_in1(v_set1),
    .pmemaddr_sel,
    // outputs
    .lru_out(lru), .d_out0(dirty0), .d_out1(dirty1), .hit0, .hit1,

    /* CPU signals */
    .mem_byte_enable, .mem_address, .mem_wdata,      // inputs
    .mem_rdata,                                      // outputs

    /* Memory signals */
    .pmem_read, .pmem_rdata,                         // inputs
    .pmem_address, .pmem_wdata                       // outputs

);

endmodule : l2_cache
