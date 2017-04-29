import lc3b_types::*;

module hardware_prefetcher
(
    input clk,

    /***** I-Cache Signals *****/
    input i_read, i_write,
    input lc3b_word i_address,
    input lc3b_cacheline i_wdata,
    output logic i_resp,
    output lc3b_cacheline i_rdata,

    /***** L2 Arbiter Signals *****/
    input l2_resp,
    input lc3b_cacheline l2_rdata,
    output logic l2_read, l2_write,
    output lc3b_word l2_address,
    output lc3b_cacheline l2_wdata
);


/***** Internal Signals *****/
logic load_pf_line, load_pf_addr, i_rdata_sel, valid, l2_address_sel;
lc3b_word prefetch_addr_cur;

assign l2_wdata = i_wdata;
assign l2_write = i_write;

hardware_prefetcher_controller controller
(
    .clk,

    .prefetch_addr(prefetch_addr_cur), .valid,
    .load_pf_line, .load_pf_addr, .i_rdata_sel, .l2_address_sel,

    .i_read, .i_address, .i_resp,

    .l2_resp, .l2_read
);

hardware_prefetcher_datapath datapath
(
    .clk,

    .load_pf_line, .load_pf_addr, .i_rdata_sel, .l2_address_sel,
    .prefetch_addr_out(prefetch_addr_cur), .valid,

    .i_address, .i_rdata,

    .l2_rdata, .l2_read, .l2_address
);


endmodule : hardware_prefetcher
