/*
 * arbiter.sv, by the Silver Pipelining team.
 */

import lc3b_types::*;

module arbiter
(
    input clk,

    // Inputs from split L1 cache
    input lc3b_word priority2_address_in, priority1_address_in,
    input lc3b_cacheline priority2_wdata_in, priority1_wdata_in,
    input priority2_read_in, priority1_read_in,
    input priority2_write_in, priority1_write_in,

    // Outputs to the split L1 cache
    output priority1_resp_out, priority2_resp_out,
    output lc3b_cacheline priority1_rdata_out, priority2_rdata_out,

    // Inputs from the L2 cache
    input lc3b_cacheline s_rdata_in,
    input s_resp_in,

    // Outputs to the L2 cache
    output lc3b_word s_address_out,
    output lc3b_cacheline s_wdata_out,
    output s_read_out, s_write_out
);

// Internal signal, to be passed between datapath and control
logic cache_arbiter_sel, access;
lc3b_cacheline priority2_wdata_in_sync, priority1_wdata_in_sync;
logic priority2_read_in_sync, priority1_read_in_sync;
logic priority2_write_in_sync, priority1_write_in_sync;
lc3b_word priority2_address_in_sync, priority1_address_in_sync;


 // Datapath inst
arbiter_datapath datapath
(
    .priority2_address_in(priority2_address_in_sync), .priority1_address_in(priority1_address_in_sync),
    .priority2_wdata_in(priority2_wdata_in_sync), .priority1_wdata_in(priority1_wdata_in_sync),
    .priority2_read_in(priority2_read_in_sync), .priority1_read_in(priority1_read_in_sync),
    .priority2_write_in(priority2_write_in_sync), .priority1_write_in(priority1_write_in_sync),
    .s_rdata_in(s_rdata_in), .s_resp_in(s_resp_in),
    .cache_arbiter_sel,
    .s_address_out(s_address_out), .s_wdata_out(s_wdata_out),
    .s_read_out(s_read_out), .s_write_out(s_write_out),
    .priority2_resp_out, .priority1_resp_out,
    .priority2_rdata_out, .priority1_rdata_out
);

// Control unit inst
arbiter_control control
(
    .clk,
    .priority2_read_in(priority2_read_in_sync), .priority1_read_in(priority1_read_in_sync),
    .priority2_write_in(priority2_write_in_sync), .priority1_write_in(priority1_write_in_sync),
    .s_resp_in(s_resp_in),
    .cache_arbiter_sel, .access
);

 // Synchronize between L1 and the arbiter
always_ff @ (posedge clk) begin
    priority1_read_in_sync <= priority1_read_in & access;
    priority1_write_in_sync <= priority1_write_in & access;
    priority1_address_in_sync <= priority1_address_in;
    priority1_wdata_in_sync <= priority1_wdata_in;

    priority2_read_in_sync <= priority2_read_in & access;
    priority2_write_in_sync <= priority2_write_in & access;
    priority2_wdata_in_sync <= priority2_wdata_in;
    priority2_address_in_sync <= priority2_address_in;
end

endmodule : arbiter
