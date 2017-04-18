import lc3b_types::*;

module eviction_buffer_datapath
(
    input clk,

    input buf_mem_read, buf_mem_write,
    input lc3b_word buf_mem_address,
    input lc3b_cacheline buf_mem_wdata,
    // outputs
    output logic buf_mem_resp,
    output lc3b_cacheline buf_mem_rdata,

    /******* Signals between L2 Cache and Physical Memory *******/
    // inputs
    input super_mem_resp,
    input lc3b_cacheline super_mem_rdata,
    // outputs
    output logic super_mem_read, super_mem_write,
    output lc3b_word super_mem_address,
    output lc3b_cacheline super_mem_wdata
);

/* Internal connections */




endmodule : eviction_buffer_datapath
