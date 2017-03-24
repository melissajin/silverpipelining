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
	input lc3b_word i_cache_address_in, d_cache_address_in,
	input lc3b_cacheline i_cache_wdata_in, d_cache_wdata_in,
	input i_cache_read_in, d_cache_read_in,
	input i_cache_write_in, d_cache_write_in,

	// Inputs from the L2 cache
	input lc3b_cacheline l2_rdata_in,
	input l2_resp_in,

	// Inputs from the arbiter control
	input cache_arbiter_sel,

	// Outputs to the L2 cache
	output lc3b_word l2_address_out,
	output lc3b_cacheline l2_wdata_out,
	output logic l2_read_out,
	output logic l2_write_out,

	// Outputs to the split L1 cache
	output logic i_cache_resp_out, d_cache_resp_out,
	output lc3b_cacheline i_cache_rdata_out, d_cache_rdata_out
 );

 // Most of the datapath consists of pairs of MUXes
 // that select between I-CACHE and D-CACHE signals
mux2 #(.width(16)) addrmux
(
	.sel(cache_arbiter_sel),
	.a(i_cache_address_in),
	.b(d_cache_address_in),
	.f(l2_address_out)
);

mux2 #(.width(128)) wdatamux
(
	.sel(cache_arbiter_sel),
	.a(i_cache_wdata_in),
	.b(d_cache_wdata_in),
	.f(l2_wdata_out)
);

mux2 #(.width(1)) readmux
(
	.sel(cache_arbiter_sel),
	.a(i_cache_read_in),
	.b(d_cache_read_in),
	.f(l2_read_out)
);

mux2 #(.width(1)) writemux
(
	.sel(cache_arbiter_sel),
	.a(i_cache_write_in),
	.b(d_cache_write_in),
	.f(l2_write_out)
);

always_comb
	begin
		d_cache_resp_out = cache_arbiter_sel & l2_resp_in; // Output memory response signals
		i_cache_resp_out = ~cache_arbiter_sel & l2_resp_in;
		d_cache_rdata_out = l2_rdata_in;
		i_cache_rdata_out = l2_rdata_in;
	end

 endmodule : arbiter_datapath
