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

/******* Signals between Victim Cache and L2 Cache *******/
logic buf_mem_read_l2, buf_mem_write_l2;
lc3b_word buf_mem_address_l2;
lc3b_cacheline buf_mem_wdata_l2;
logic buf_mem_resp_l2;
lc3b_cacheline buf_mem_rdata_l2;
logic eviction_l2;

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

/********  Signals between Prefetcher and L2 Arbiter, Prefetcher and PMEM Arbiter ********/
logic l2_arbit_resp_i, l2_arbit_read_i, l2_arbit_write_i;
lc3b_word l2_arbit_address_i;
lc3b_cacheline l2_arbit_rdata_i, l2_arbit_wdata_i;

logic pf_arbit_resp_i, pf_arbit_read_i, pf_arbit_write_i;
lc3b_word pf_arbit_address_i;
lc3b_cacheline pf_arbit_rdata_i, pf_arbit_wdata_i;

logic pmem_arbit_resp, pmem_arbit_read, pmem_arbit_write;
lc3b_word pmem_arbit_address;
lc3b_cacheline pmem_arbit_rdata, pmem_arbit_wdata;

/********  Signals between CPU and L1 D and I Caches ********/
logic i_mem_resp, i_mem_read, i_mem_write;
lc3b_mem_wmask i_mem_byte_enable;
lc3b_word i_mem_rdata, i_mem_address, i_mem_wdata;

logic d_mem_resp, d_mem_read, d_mem_write;
lc3b_mem_wmask d_mem_byte_enable;
lc3b_word d_mem_rdata, d_mem_address, d_mem_wdata;
logic eviction_l1_d, eviction_l1_i;

/********  Signals between Lower Victim Cache and L1 D and I Cache ********/
logic buf_mem_read_l1_d, buf_mem_write_l1_d;
lc3b_word buf_mem_address_l1_d;
lc3b_cacheline buf_mem_wdata_l1_d;
logic buf_mem_resp_l1_d;
lc3b_cacheline buf_mem_rdata_l1_d;

logic buf_mem_read_l1_i, buf_mem_write_l1_i;
lc3b_word buf_mem_address_l1_i;
lc3b_cacheline buf_mem_wdata_l1_i;
logic buf_mem_resp_l1_i;
lc3b_cacheline buf_mem_rdata_l1_i;

victim_cache victim_cache_l2
(
    .clk,

    /******* Signals between Victim Cache and Physical Memory *******/
    .s_mem_resp(pmem_resp),
    .s_mem_rdata(pmem_rdata),
    .s_mem_read(pmem_read), .s_mem_write(pmem_write),
    .s_mem_address(pmem_address),
    .s_mem_wdata(pmem_wdata),

    /******* Signals between Victim Cache and L2 Cache *******/
    .buf_mem_read(buf_mem_read_l2), .buf_mem_write(buf_mem_write_l2),
    .buf_mem_address(buf_mem_address_l2),
    .buf_mem_wdata(buf_mem_wdata_l2),
    .buf_mem_resp(buf_mem_resp_l2),
    .buf_mem_rdata(buf_mem_rdata_l2),
    .eviction(eviction_l2)
);

l2_cache l2_inst
(
    .clk,

    /******* Signals between L2 Cache and Victim Cache  *******/
    .pmem_resp(buf_mem_resp_l2),
    .pmem_rdata(buf_mem_rdata_l2),
    .pmem_read(buf_mem_read_l2), .pmem_write(buf_mem_write_l2),
    .pmem_address(buf_mem_address_l2),
    .pmem_wdata(buf_mem_wdata_l2),
    .eviction(eviction_l2),

    /******* Signals between Arbiter and L2 Cache *******/
    .mem_read(L2_read), .mem_write(L2_write),
    .mem_address(L2_address), .mem_wdata(L2_wdata),
    .mem_resp(L2_resp),
    .mem_rdata(L2_rdata)
);

arbiter l2_arbiter
(
    .clk,

    /******* Signals between Arbiter and L2 *******/
    .s_rdata_in(L2_rdata),
    .s_resp_in(L2_resp),
    .s_address_out(L2_address),
    .s_wdata_out(L2_wdata), .s_read_out(L2_read),
    .s_write_out(L2_write),

    /******* Signals between Arbiter and L1 Victim Caches *******/
    .priority2_address_in(l2_arbit_address_i), .priority1_address_in(address_d),
    .priority2_wdata_in(l2_arbit_wdata_i), .priority1_wdata_in(wdata_d),
    .priority2_read_in(l2_arbit_read_i), .priority1_read_in(read_d),
    .priority2_write_in(l2_arbit_write_i), .priority1_write_in(write_d),
    .priority2_resp_out(l2_arbit_resp_i), .priority1_resp_out(resp_d),
    .priority2_rdata_out(l2_arbit_rdata_i), .priority1_rdata_out(rdata_d)
);

victim_cache victim_cache_l1_d
(
    .clk,

    /******* Signals between Victim Cache and Arbiter *******/
    .s_mem_resp(resp_d),
    .s_mem_rdata(rdata_d),
    .s_mem_read(read_d), .s_mem_write(write_d),
    .s_mem_address(address_d),
    .s_mem_wdata(wdata_d),

    /******* Signals between Victim Cache and L1 Data Cache *******/
    .buf_mem_read(buf_mem_read_l1_d), .buf_mem_write(buf_mem_write_l1_d),
    .buf_mem_address(buf_mem_address_l1_d),
    .buf_mem_wdata(buf_mem_wdata_l1_d),
    .buf_mem_resp(buf_mem_resp_l1_d),
    .buf_mem_rdata(buf_mem_rdata_l1_d),
    .eviction(eviction_l1_d)
);

l1_cache d_cache
(
    .clk,

    /******* Signals between Cache and Lower Victim Cache *******/
    .l2_resp(buf_mem_resp_l1_d), .l2_rdata(buf_mem_rdata_l1_d),
    .l2_read(buf_mem_read_l1_d), .l2_write(buf_mem_write_l1_d),
    .l2_address(buf_mem_address_l1_d), .l2_wdata(buf_mem_wdata_l1_d),
    .eviction(eviction_l1_d),

    /******* Signals between CPU and Cache *******/
    .mem_read(d_mem_read), .mem_write(d_mem_write), .mem_byte_enable(d_mem_byte_enable),
    .mem_address(d_mem_address), .mem_wdata(d_mem_wdata),
    .mem_resp(d_mem_resp), .mem_rdata(d_mem_rdata)
);

hardware_prefetcher prefetcher
(
    .clk,

    /***** L2 Arbiter Signals *****/
    .l2_read(l2_arbit_read_i), .l2_write(l2_arbit_write_i), .l2_address(l2_arbit_address_i), .l2_wdata(l2_arbit_wdata_i),
    .l2_resp(l2_arbit_resp_i), .l2_rdata(l2_arbit_rdata_i),

    /***** I-Cache Signals *****/
    .i_read(read_i), .i_write(write_i), .i_address(address_i), .i_wdata(wdata_i),
    .i_resp(resp_i), .i_rdata(rdata_i)
);

victim_cache victim_cache_l1_i
(
    .clk,

    /******* Signals between Victim Cache and Arbiter *******/
    .s_mem_resp(resp_i),
    .s_mem_rdata(rdata_i),
    .s_mem_read(read_i), .s_mem_write(write_i),
    .s_mem_address(address_i),
    .s_mem_wdata(wdata_i),

    /******* Signals between Victim Cache and L1 Data Cache *******/
    .buf_mem_read(buf_mem_read_l1_i), .buf_mem_write(buf_mem_write_l1_i),
    .buf_mem_address(buf_mem_address_l1_i),
    .buf_mem_wdata(buf_mem_wdata_l1_i),
    .buf_mem_resp(buf_mem_resp_l1_i),
    .buf_mem_rdata(buf_mem_rdata_l1_i),
    .eviction(eviction_l1_i)
);

l1_cache i_cache
(
    .clk,

    /******* Signals between Cache and Arbiter *******/
    .l2_resp(buf_mem_resp_l1_i), .l2_rdata(buf_mem_rdata_l1_i),
    .l2_read(buf_mem_read_l1_i), .l2_write(buf_mem_write_l1_i), .l2_address(buf_mem_address_l1_i), .l2_wdata(buf_mem_wdata_l1_i),
    .eviction(eviction_l1_i),

    /******* Signals between CPU and Cache *******/
    .mem_read(i_mem_read), .mem_write(i_mem_write), .mem_byte_enable(i_mem_byte_enable),
    .mem_address(i_mem_address), .mem_wdata(i_mem_wdata),
    .mem_resp(i_mem_resp), .mem_rdata(i_mem_rdata)
);

cpu cpu_inst
(
    .clk,

    /******* Instruction Memory signals *******/
    .i_mem_resp, .i_mem_rdata,
    .i_mem_read, .i_mem_address,

    /******* Data Memory signals *******/
    .d_mem_resp, .d_mem_rdata,
    .d_mem_read, .d_mem_write, .d_mem_byte_enable,
    .d_mem_address, .d_mem_wdata
);


assign i_mem_write = 1'b0;
assign i_mem_byte_enable = 2'b11;
assign i_mem_wdata = 16'h0000;

endmodule : mp0
