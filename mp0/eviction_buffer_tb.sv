import lc3b_types::*;

module eviction_buffer_tb;

timeunit 1ns;
timeprecision 1ns;

logic clk;
logic buf_mem_read, buf_mem_write;
lc3b_word buf_mem_address;
lc3b_cacheline buf_mem_wdata;
logic buf_mem_resp;
lc3b_cacheline buf_mem_rdata;
logic super_mem_resp;
lc3b_cacheline super_mem_rdata;
logic super_mem_read, super_mem_write;
lc3b_word super_mem_address;
lc3b_cacheline super_mem_wdata;

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
		buf_mem_wdata = 128'hFFFFFFFFF;
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
		buf_mem_wdata = 128'hEEEEEEEEEEE;
		// Since buf_mem_resp is already set, we cant wait for posedge ... no need to wait
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0020;
		buf_mem_wdata = 128'hDDDDDDDDDDDD;
		wait_for_mresp();
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0030;
		buf_mem_wdata = 128'hCCCCCCCCCCCCC;
		wait_for_mresp();
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0040;
		buf_mem_wdata = 128'hBBBBBBBBBBBBBBBBBBBB;
		wait_for_mresp();
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0050;
		buf_mem_wdata = 128'hAAAAAAAAAAAAAAAAAAAA;
		wait_for_mresp();
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0060;
		buf_mem_wdata = 128'h999999999999999999999;
		wait_for_mresp();
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0070;
		buf_mem_wdata = 128'h888888888888888888888;
		wait_for_mresp();
	#10
		buf_mem_read = 0;
		buf_mem_write = 1;
		buf_mem_address = 16'h0080;
		buf_mem_wdata = 128'h777777777777777777777;
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

eviction_buffer DUT
(
	.*
);

physical_memory memory
(
    .clk,
    .read(super_mem_read),
    .write(super_mem_write),
    .address(super_mem_address),
    .wdata(super_mem_wdata),
    .resp(super_mem_resp),
    .rdata(super_mem_rdata)
);


endmodule : eviction_buffer_tb
