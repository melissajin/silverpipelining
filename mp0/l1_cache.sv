import lc3b_types::*;

module l1_cache
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
    input l2_resp,                                                    // control
    input lc3b_cacheline l2_rdata,                                    // datapath
    // outputs
    output logic l2_read, l2_write,                                   // control
    output lc3b_word l2_address,                                      // datapath
    output lc3b_cacheline l2_wdata,                                    // datapath
    output logic eviction,
    
    // Performance counter signals
    output logic l1hits_inc, l1misses_inc
);

logic load_lru, l2wdata_sel;
logic load_d0, load_v0, load_TD0, d_set0, v_set0;
logic load_d1, load_v1, load_TD1, d_set1, v_set1;
logic [1:0] l2addr_sel;
logic lru, lru_set, dirty0, dirty1, valid0, valid1, hit0, hit1;
lc3b_word l2_address_inter;
lc3b_cacheline l2_wdata_inter;

l1_cache_control control
(
    .clk,

    /* Datapath controls */
    // inputs
    .lru_in(lru), .d_in0(dirty0), .d_in1(dirty1),
    .v_in0(valid0), .v_in1(valid1), .hit0, .hit1,

    // outputs
    .load_lru, .lru_set, .l2wdata_sel,
    .load_d0, .load_v0, .load_TD0, .d_set0(d_set0), .v_set0(v_set0),
    .load_d1, .load_v1, .load_TD1, .d_set1(d_set1), .v_set1(v_set1),
    .l2addr_sel,

    /* CPU signals */
    .mem_read, .mem_write,                              // inputs
    .mem_resp,                                          // outputs

    /* Memory signals */
    .l2_resp, .l2_address_inter, .l2_wdata_inter,              // inputs
    .l2_read, .l2_write, .l2_address, .l2_wdata,                // outputs
    .eviction,
    
    // Performance counter signals
    .l1hits_inc, .l1misses_inc
);


l1_cache_datapath datapath
(
    .clk,

    /* Control signals */
    // inputs
    .load_lru, .lru_in(lru_set), .l2wdata_sel,
    .load_d0, .load_v0, .load_TD0, .d_in0(d_set0), .v_in0(v_set0),
    .load_d1, .load_v1, .load_TD1, .d_in1(d_set1), .v_in1(v_set1),
    .l2addr_sel,
    // outputs
    .lru_out(lru), .d_out0(dirty0), .d_out1(dirty1), .hit0, .hit1,
    .v_out0(valid0), .v_out1(valid1),    

    /* CPU signals */
    .mem_byte_enable, .mem_address, .mem_wdata,      // inputs
    .mem_rdata,                                      // outputs

    /* Memory signals */
    .l2_read, .l2_rdata,                             // inputs
    .l2_address_inter, .l2_wdata_inter               // outputs

);

endmodule : l1_cache
