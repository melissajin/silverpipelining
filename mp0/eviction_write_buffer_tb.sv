import lc3b_types::*;

module array_fa_tb;

timeunit 1ns;
timeprecision 1ns;

logic clk;
logic buf_mem_read, buf_mem_write;
lc3b_word buf_mem_address;
lc3b_cacheline buf_mem_wdata;
logic buf_mem_resp;
logic lc3b_cacheline buf_mem_rdata;
logic super_mem_resp;
lc3b_cacheline super_mem_rdata;
logic super_mem_read, super_mem_write;
lc3b_word super_mem_address,
lc3b_cacheline super_mem_wdata;

initial
begin: TEST_SIGNALS

	#5
		// set ssignals
		wait(super_mem_resp);
	#20

end

module eviction_buffer
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


endmodule : array_fa_tb
