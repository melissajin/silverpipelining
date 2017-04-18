import lc3b_types::*;

module array_fa_tb;

timeunit 1ns;
timeprecision 1ns;

logic clk;
logic write;
lc3b_c_index index;
logic [127:0] datain;
logic [127:0] dataout [7:0];
/* Clock generator */
initial clk = 0;
always #5 clk = ~clk;

initial
begin: TEST_SIGNALS
	write = 0;
	index = 0;
	datain = 0;

	#5
		datain = 128'hffff;
		index = 3;
		write = 1;
	#20
		write = 0;
	#20
		datain = 128'hffff;
		index = 7;
		write = 1;
end

array_fully_associative array_fa(
	.clk,
	.write,
	.index,
	.datain,
	.dataout
);

endmodule : array_fa_tb
