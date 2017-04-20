/*
 * arbiter_datapath.sv, by the Silver Pipelining team
 * This is the module containing the combinational logic for our cache arbiter,
 * which aims to mediate control signal and data flow between the split L1 cache
 * and the L2 cache.  This datapath is driven by a cache arbiter controller, which
 * also ensures the L2 doesn't see reads until 1 cycle after an L1 miss.
 */

 import lc3b_types::*; /* Import types defined in lc3b_types.sv */

 module arbiter_datapath
 (
	// Inputs from the split L1 cache
	input lc3b_word priority2_address_in, priority1_address_in,
	input lc3b_cacheline priority2_wdata_in, priority1_wdata_in,
	input priority2_read_in, priority1_read_in,
	input priority2_write_in, priority1_write_in,

	// Inputs from the L2 cache
	input lc3b_cacheline s_rdata_in,
	input s_resp_in,

	// Inputs from the arbiter control
	input cache_arbiter_sel,

	// Outputs to the L2 cache
	output lc3b_word s_address_out,
	output lc3b_cacheline s_wdata_out,
	output logic s_read_out,
	output logic s_write_out,

	// Outputs to the split L1 cache
	output logic priority2_resp_out, priority1_resp_out,
	output lc3b_cacheline priority2_rdata_out, priority1_rdata_out
 );

 // Most of the datapath consists of pairs of MUXes
 // that select between I-CACHE and D-CACHE signals
mux2 #(.width(16)) addrmux
(
	.sel(cache_arbiter_sel),
	.a(priority2_address_in),
	.b(priority1_address_in),
	.f(s_address_out)
);

mux2 #(.width(128)) wdatamux
(
	.sel(cache_arbiter_sel),
	.a(priority2_wdata_in),
	.b(priority1_wdata_in),
	.f(s_wdata_out)
);

mux2 #(.width(1)) readmux
(
	.sel(cache_arbiter_sel),
	.a(priority2_read_in),
	.b(priority1_read_in),
	.f(s_read_out)
);

mux2 #(.width(1)) writemux
(
	.sel(cache_arbiter_sel),
	.a(priority2_write_in),
	.b(priority1_write_in),
	.f(s_write_out)
);

always_comb begin
	priority1_resp_out = cache_arbiter_sel & s_resp_in; // Output memory response signals
	priority2_resp_out = ~cache_arbiter_sel & s_resp_in;
	priority1_rdata_out = s_rdata_in;
	priority2_rdata_out = s_rdata_in;
end

 endmodule : arbiter_datapath
