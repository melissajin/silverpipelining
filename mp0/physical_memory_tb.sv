import lc3b_types::*;

module physical_memory_tb;

timeunit 1ns;
timeprecision 1ns;


logic clk;
logic read;
logic write;
logic [15:0] address;
logic [127:0] wdata;
logic resp;
logic [127:0] rdata;


/* Clock generator */
initial clk = 0;
always #5 clk = ~clk;

task wait_for_mresp;
	@(posedge resp);
endtask : wait_for_mresp

initial
begin: TEST_SIGNALS
 	read = 0;
 	write = 0;
 	address = 0;
	wdata = 0;

	#10
		read = 1;
		address = 16'h0000;
	#200
		address = 16'h0010;
		wait_for_mresp();
	#230
		address = 16'h0000;
		wait_for_mresp();
		read = 0;
end

physical_memory DUT ( .* );


endmodule : physical_memory_tb
