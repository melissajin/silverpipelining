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

/******** Signals between arbiter and L2 cache ********/
logic L2_read, L2_write, L2_resp;
lc3b_word L2_address;
lc3b_cacheline L2_wdata, L2_rdata;


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

/*******  Signals relating to performance counters  **********/
logic l2hits_inc, l2hits_clear;
lc3b_word l2hits_out;

logic l2misses_inc, l2misses_clear;
lc3b_word l2misses_out;

logic dl1hits_inc, dl1hits_clear;
lc3b_word dl1hits_out;

logic dl1misses_inc, dl1misses_clear;
lc3b_word dl1misses_out;

logic il1hits_inc, il1hits_clear;
lc3b_word il1hits_out;

logic il1misses_inc, il1misses_clear;
lc3b_word il1misses_out;

logic bpredicts_inc, bpredicts_clear;
lc3b_word bpredicts_out;

logic bmispredicts_inc, bmispredicts_clear;
lc3b_word bmispredicts_out;

logic stalls_inc, stalls_clear;
lc3b_word stalls_out;

logic [8:0] counter_clear_vec;
logic stall_pipe;

// Nine performance counters
performance_counter l2hits
(
    .clk,
    .increment(l2hits_inc & ~stall_pipe),
    .clear(l2hits_clear),
    .output_count(l2hits_out)
);

performance_counter l2misses
(
    .clk,
    .increment(l2misses_inc),
    .clear(l2misses_clear),
    .output_count(l2misses_out)
);

performance_counter dl1hits
(
    .clk,
    .increment(dl1hits_inc),
    .clear(dl1hits_clear),
    .output_count(dl1hits_out)
);

performance_counter dl1misses
(
    .clk,
    .increment(dl1misses_inc),
    .clear(dl1misses_clear),
    .output_count(dl1misses_out)
);

performance_counter il1hits
(
    .clk,
    .increment(il1hits_inc & ~stall_pipe),
    .clear(il1hits_clear),
    .output_count(il1hits_out)
);

performance_counter il1misses
(
    .clk,
    .increment(il1misses_inc),
    .clear(il1misses_clear),
    .output_count(il1misses_out)
);

performance_counter bpredicts
(
    .clk,
    .increment(bpredicts_inc),
    .clear(bpredicts_clear),
    .output_count(bpredicts_out)
);

performance_counter bmispredicts
(
    .clk,
    .increment(bmispredicts_inc),
    .clear(bmispredicts_clear),
    .output_count(bmispredicts_out)
);

performance_counter stalls
(
    .clk,
    .increment(stalls_inc),
    .clear(stalls_clear),
    .output_count(stalls_out)
);

l2_cache l2_inst
(
    .clk,

    /******* Signals between Arbiter and L2 Cache *******/
    // inputs
    .mem_read(L2_read), .mem_write(L2_write),                                          // control
    .mem_address(L2_address), .mem_wdata(L2_wdata),                             // datapath
    // outputs
    .mem_resp(L2_resp),                                              // control
    .mem_rdata(L2_rdata),                                         // datapath

    /******* Signals between L2 Cache and Physical Memory *******/
    // inputs
    .pmem_resp(pmem_resp),                                                    // control
    .pmem_rdata(pmem_rdata),                                    // datapath
    // outputs
    .pmem_read(pmem_read), .pmem_write(pmem_write),                                   // control
    .pmem_address(pmem_address),                                      // datapath
    .pmem_wdata(pmem_wdata),                                    // datapath

    /******* Performance counter signals *******/
    .l2hits_inc, .l2misses_inc
);

// assign pmem_address = L2_address;
// assign pmem_wdata = L2_wdata;
// assign pmem_read = (L2_read);
// assign pmem_write = (L2_write);
// assign L2_resp = pmem_resp;
// assign L2_rdata = pmem_rdata;


arbiter arbiter_inst
(
    .clk,

    // Inputs from split L1 cache
    .i_cache_address_in(address_i), .d_cache_address_in(address_d),
    .i_cache_wdata_in(wdata_i), .d_cache_wdata_in(wdata_d),
    .i_cache_read_in(read_i), .d_cache_read_in(read_d),
    .i_cache_write_in(write_i), .d_cache_write_in(write_d),

    // Inputs from the L2 cache
    .l2_rdata_in(L2_rdata), // TODO: change to L2. using Pmem right now
    .l2_resp_in(L2_resp),

    // Outputs to the L2 cache
    .l2_address_out(L2_address), // TODO: change to L2. using Pmem right now
    .l2_wdata_out(L2_wdata), .l2_read_out(L2_read),
    .l2_write_out(L2_write),

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
    .l2_read(read_d), .l2_write(write_d), .l2_address(address_d), .l2_wdata(wdata_d),          // outputs

    /******* Performance counter signals *******/
    .l1hits_inc(dl1hits_inc), .l1misses_inc(dl1misses_inc)
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
    .l2_read(read_i), .l2_write(write_i), .l2_address(address_i), .l2_wdata(wdata_i),          // outputs

    /******* Performance counter signals *******/
    .l1hits_inc(il1hits_inc), .l1misses_inc(il1misses_inc)
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
    .d_mem_address, .d_mem_wdata,

    /* Peformance counter signals */
    .l2hits_out, .l2misses_out, .dl1hits_out, .dl1misses_out, .il1hits_out,
    .il1misses_out, .bpredicts_out, .bmispredicts_out, .stalls_out,
    .counter_clear_vec, .bpredicts_inc, .bmispredicts_inc, .stalls_inc,
    .stall_pipe
);


assign i_mem_write = 1'b0;
assign i_mem_byte_enable = 2'b11;
assign i_mem_wdata = 16'h0000;

assign l2hits_clear = counter_clear_vec[0];
assign l2misses_clear = counter_clear_vec[1];
assign dl1hits_clear = counter_clear_vec[2];
assign dl1misses_clear = counter_clear_vec[3];
assign il1hits_clear = counter_clear_vec[4];
assign il1misses_clear = counter_clear_vec[5];
assign bpredicts_clear = counter_clear_vec[6];
assign bmispredicts_clear = counter_clear_vec[7];
assign stalls_clear = counter_clear_vec[8];

endmodule : mp0
