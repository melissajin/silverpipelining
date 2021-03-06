import lc3b_types::*;

module victim_cache_tb;

timeunit 1ns;
timeprecision 1ns;

logic clk;
logic buf_mem_read, buf_mem_write;
lc3b_word buf_mem_address;
lc3b_cacheline buf_mem_wdata;
logic buf_mem_resp;
lc3b_cacheline buf_mem_rdata;
logic s_mem_resp;
lc3b_cacheline s_mem_rdata;
logic s_mem_read, s_mem_write;
lc3b_word s_mem_address;
lc3b_cacheline s_mem_wdata;

/* Clock generator */
initial clk = 0;
always #5 clk = ~clk;

task wait_for_mresp;
	@(posedge buf_mem_resp);
endtask : wait_for_mresp

initial
begin: TEST_SIGNALS
	buf_mem_read = 0;
	buf_mem_write = 0;
	buf_mem_address = 0;
	buf_mem_wdata = 0;

	#10
		buf_mem_read = 1;
		buf_mem_address = 0;
		wait_for_mresp();
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0010;
		buf_mem_wdata = 256'hFFFFFFFFF;
		// Since buf_mem_resp is already set, we cant wait for posedge ... no need to wait
	#10
		buf_mem_write = 0;
		buf_mem_read = 1;
		buf_mem_address = 16'h0020;
		wait_for_mresp();
	#10
		buf_mem_read = 1;
		buf_mem_address = 16'h0010;
		// Since this is a read hit, we wont see a posedge ... no need to wait
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0010;
		buf_mem_wdata = 256'hEEEEEEEEEEE;
		// Since buf_mem_resp is already set, we cant wait for posedge ... no need to wait
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0020;
		buf_mem_wdata = 256'hDDDDDDDDDDDD;
		wait_for_mresp();
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0030;
		buf_mem_wdata = 256'hCCCCCCCCCCCCC;
		wait_for_mresp();
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0040;
		buf_mem_wdata = 256'hBBBBBBBBBBBBBBBBBBBB;
		wait_for_mresp();
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0050;
		buf_mem_wdata = 256'hAAAAAAAAAAAAAAAAAAAA;
		wait_for_mresp();
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0060;
		buf_mem_wdata = 256'h999999999999999999999;
		wait_for_mresp();
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0070;
		buf_mem_wdata = 256'h888888888888888888888;
		wait_for_mresp();
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0080;
		buf_mem_wdata = 256'h777777777777777777777;
		wait_for_mresp();
	#10
		buf_mem_write = 0;
	#100
		buf_mem_read = 1;
		buf_mem_address = 16'h0040;
		wait_for_mresp();
	#10
		buf_mem_read = 1;
		buf_mem_address = 16'h0000;
		wait_for_mresp();
	#10
		buf_mem_read = 0;

end

victim_cache DUT
(
	.*
);

physical_memory memory
(
    .clk,
    .read(s_mem_read),
    .write(s_mem_write),
    .address(s_mem_address),
    .wdata(s_mem_wdata),
    .resp(s_mem_resp),
    .rdata(s_mem_rdata)
);


endmodule : victim_cache_tb
