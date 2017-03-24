/*
 * arbiter.sv, by the Silver Pipelining team.
 */
 
 module arbiter
 (
	input clk,
	
	// Inputs from split L1 cache
	input lc3b_word i_cache_address_in, d_cache_address_in,
	input lc3b_cacheline i_cache_wdata_in, d_cache_wdata_in,
	input i_cache_read_in, d_cache_read_in,
	input i_cache_write_in, d_cache_write_in,
	
	// Inputs from the L2 cache
	input lc3b_cacheline l2_rdata_in,
	input l2_resp_in,
	
	// Outputs to the L2 cache
	output lc3b_word l2_address_out,
	output lc3b_cacheline l2_wdata_out,
	output l2_read_out,
	output l2_write_out,
	
	// Outputs to the split L1 cache
	output d_cache_resp_out, i_cache_resp_out,
	output lc3b_cacheline d_cache_rdata_out, i_cache_rdata_out
 );
 
 // Internal signal, to be passed between datapath and control
 logic cache_arbiter_sel;
 
 // Datapath inst
 arbiter_datapath gavel
 (
	.i_cache_address_in, .d_cache_address_in,
	.i_cache_wdata_in, .d_cache_wdata_in,
	.i_cache_read_in, .d_cache_read_in,
	.i_cache_write_in, .d_cache_write_in,
	.l2_rdata_in, .l2_resp_in,
	.cache_arbiter_sel,
	.l2_address_out, .l2_wdata_out,
	.l2_read_out, .l2_write_out,
	.i_cache_resp_out, .d_cache_resp_out,
	.i_cache_rdata_out, .d_cache_rdata_out
 );
 
 // Control unit inst
 arbiter_control judge
 (
	.clk,
	.i_cache_read_in, .d_cache_read_in,
	.i_cache_write_in, .d_cache_write_in,
	.l2_resp_in,
	.cache_arbiter_sel
 );
 
 endmodule : arbiter