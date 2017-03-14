module mp0_tb;

timeunit 1ns;
timeprecision 1ns;

logic clk;
logic resp_a, resp_b;
logic read_a, read_b;
logic write_a, write_b;
logic [1:0] wmask_a, wmask_b;
logic [15:0] address_a, address_b;
logic [15:0] rdata_a, rdata_b;
logic [15:0] wdata_a, wdata_b;

assign wmask_a = 2'b11;
assign write_a = 1'b0;
assign wdata_a = 16'h0000;


/* Clock generator */
initial clk = 0;
always #5 clk = ~clk;

mp0 dut
(
    .clk,

    /* Instruction Memory signals */
    .i_mem_resp(resp_a), .i_mem_rdata(rdata_a), .i_mem_read(read_a),
    .i_mem_address(address_a),

    /* Data Memory signals */
    .d_mem_resp(resp_b), .d_mem_rdata(rdata_b), .d_mem_read(read_b),
    .d_mem_write(write_b), .d_mem_byte_enable(wmask_b),
    .d_mem_address(address_b), .d_mem_wdata(wdata_b)
);
magic_memory_dp memory
(
    .*
);



endmodule : mp0_tb
