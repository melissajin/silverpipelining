import lc3b_types::*;

module mp0
(
    input clk,

    /* Instruction Memory signals */
    input logic resp_i,
    input logic [127:0] rdata_i,

    output logic read_i,
    output logic write_i,
    output logic [15:0] address_i,
    output logic [127:0] wdata_i,

    /* Data Memory signals */
    input logic resp_d,
    input logic [127:0] rdata_d,

    output logic read_d,
    output logic write_d,
    output logic [15:0] address_d,
    output logic [127:0] wdata_d
);

/* Signals between CPU and L1 D and I Caches */
logic i_mem_resp, i_mem_read, i_mem_write;
lc3b_mem_wmask i_mem_byte_enable;
lc3b_word i_mem_rdata, i_mem_address, i_mem_wdata;

logic d_mem_resp, d_mem_read, d_mem_write;
lc3b_mem_wmask d_mem_byte_enable;
lc3b_word d_mem_rdata, d_mem_address, d_mem_wdata;

l1_cache d_cache
(
    .clk,

    /******* Signals between CPU and Cache *******/
    // inputs
    .mem_read(d_mem_read), .mem_write(d_mem_write), .mem_byte_enable(d_mem_byte_enable),
    .mem_address(d_mem_address), .mem_wdata(d_mem_wdata),
    // outputs
    .mem_resp(d_mem_resp), .mem_rdata(d_mem_rdata),

    /******* Signals between Cache and Arbiter *******/
    .l2_resp(resp_d), .l2_rdata(rdata_d),                                                     // inputs
    .l2_read(read_d), .l2_write(write_d), .l2_address(address_d), .l2_wdata(wdata_d)          // outputs
);

l1_cache i_cache
(
    .clk,

    /******* Signals between CPU and Cache *******/
    // inputs
    .mem_read(i_mem_read), .mem_write(i_mem_write), .mem_byte_enable(i_mem_byte_enable),
    .mem_address(i_mem_address), .mem_wdata(i_mem_wdata),
    // outputs
    .mem_resp(i_mem_resp), .mem_rdata(i_mem_rdata),

    /******* Signals between Cache and Arbiter *******/
    .l2_resp(resp_i), .l2_rdata(rdata_i),                                                     // inputs
    .l2_read(read_i), .l2_write(write_i), .l2_address(address_i), .l2_wdata(wdata_i)          // outputs

);

cpu cpu_inst
(
    .clk,

    /* Instruction Memory signals */
    // inputs
    .i_mem_resp, .i_mem_rdata,
    // outputs
    .i_mem_read, .i_mem_address,

    /* Data Memory signals */
    // inputs
    .d_mem_resp, .d_mem_rdata,
    // outputs
    .d_mem_read, .d_mem_write, .d_mem_byte_enable,
    .d_mem_address, .d_mem_wdata
);


assign i_mem_write = 1'b0;
assign i_mem_byte_enable = 2'b11;
assign i_mem_wdata = 16'h0000;

endmodule : mp0
