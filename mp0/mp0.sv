import lc3b_types::*;

module mp0
(
    input clk,

    /* Memory input signals */
    input pmem_resp,
    input lc3b_cacheline pmem_rdata,

    /* Memory output signals */
    output logic pmem_read,
    output logic pmem_write,
    output lc3b_word pmem_address,
    output lc3b_cacheline pmem_wdata
);

/******** Signals between split L1 cache and arbiter ********/
/* Instruction Memory signals */
logic resp_i, read_i, write_i;
lc3b_word address_i;
lc3b_cacheline rdata_i, wdata_i;

/* Data Memory signals */
logic resp_d, read_d, write_d;
lc3b_word address_d;
lc3b_cacheline wdata_d, rdata_d;

/********  Signals between CPU and L1 D and I Caches ********/
logic i_mem_resp, i_mem_read, i_mem_write;
lc3b_mem_wmask i_mem_byte_enable;
lc3b_word i_mem_rdata, i_mem_address, i_mem_wdata;

logic d_mem_resp, d_mem_read, d_mem_write;
lc3b_mem_wmask d_mem_byte_enable;
lc3b_word d_mem_rdata, d_mem_address, d_mem_wdata;

arbiter arbiter_inst
(
    .clk,

    // Inputs from split L1 cache
    .i_cache_address_in(address_i), .d_cache_address_in(address_d),
    .i_cache_wdata_in(wdata_i), .d_cache_wdata_in(wdata_d),
    .i_cache_read_in(read_i), .d_cache_read_in(read_d),
    .i_cache_write_in(write_i), .d_cache_write_in(write_d),

    // Inputs from the L2 cache
    .l2_rdata_in(pmem_rdata), // TODO: change to L2. using Pmem right now
    .l2_resp_in(pmem_resp),

    // Outputs to the L2 cache
    .l2_address_out(pmem_address), // TODO: change to L2. using Pmem right now
    .l2_wdata_out(pmem_wdata), .l2_read_out(pmem_read),
    .l2_write_out(pmem_write),

    // Outputs to the split L1 cache
    .d_cache_resp_out(resp_d), .i_cache_resp_out(resp_i),
    .d_cache_rdata_out(rdata_d), .i_cache_rdata_out(rdata_i)

);


l1_cache d_cache
(
    .clk,

    /******* Signals between CPU and Cache *******/
    // inputs
    .mem_read(d_mem_read), .mem_write(d_mem_write), .mem_byte_enable(d_mem_byte_enable),
    .mem_address(d_mem_address), .mem_wdata(d_mem_wdata),
    // outputs
    .mem_resp(d_mem_resp), .mem_rdata(d_mem_rdata),

    /******* Signals between Cache and Arbiter *******/
    .l2_resp(resp_d), .l2_rdata(rdata_d),                                                     // inputs
    .l2_read(read_d), .l2_write(write_d), .l2_address(address_d), .l2_wdata(wdata_d)          // outputs
);

l1_cache i_cache
(
    .clk,

    /******* Signals between CPU and Cache *******/
    // inputs
    .mem_read(i_mem_read), .mem_write(i_mem_write), .mem_byte_enable(i_mem_byte_enable),
    .mem_address(i_mem_address), .mem_wdata(i_mem_wdata),
    // outputs
    .mem_resp(i_mem_resp), .mem_rdata(i_mem_rdata),

    /******* Signals between Cache and Arbiter *******/
    .l2_resp(resp_i), .l2_rdata(rdata_i),                                                     // inputs
    .l2_read(read_i), .l2_write(write_i), .l2_address(address_i), .l2_wdata(wdata_i)          // outputs

);

cpu cpu_inst
(
    .clk,

    /* Instruction Memory signals */
    // inputs
    .i_mem_resp, .i_mem_rdata,
    // outputs
    .i_mem_read, .i_mem_address,

    /* Data Memory signals */
    // inputs
    .d_mem_resp, .d_mem_rdata,
    // outputs
    .d_mem_read, .d_mem_write, .d_mem_byte_enable,
    .d_mem_address, .d_mem_wdata
);


assign i_mem_write = 1'b0;
assign i_mem_byte_enable = 2'b11;
assign i_mem_wdata = 16'h0000;

endmodule : mp0
