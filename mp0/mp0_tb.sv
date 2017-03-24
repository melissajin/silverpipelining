module mp0_tb;

timeunit 1ns;
timeprecision 1ns;

logic clk;

logic resp_i;
logic [127:0] rdata_i;

logic read_i;
logic write_i;
logic [15:0] address_i;
logic [127:0] wdata_i;

logic resp_d;
logic [127:0] rdata_d;

logic read_d;
logic write_d;
logic [15:0] address_d;
logic [127:0] wdata_d;

/* Clock generator */
initial clk = 0;
always #5 clk = ~clk;

mp0 dut
(
    .*
);

physical_memory_dp memory
(
    .*
);



endmodule : mp0_tb
