import lc3b_types::*;

module mp0
(
    input clk,

    /* Memory signals */
    input mem_resp,
    input lc3b_word mem_rdata,
    output mem_read,
    output mem_write,
    output lc3b_mem_wmask mem_byte_enable,
    output lc3b_word mem_address,
    output lc3b_word mem_wdata
);

/* Internal connections */
lc3b_opcode opcode;
logic ir_4, ir_5, ir_11;
lc3b_control_word cw;

cpu_control control
(
    .opcode(opcode), .ir_4(ir_4), .ir_5(ir_5), .ir_11(ir_11), .cw(cw)
);

cpu_datapath datapath
(
    .clk,

    /* Control Signals */
    .cw(cw), .opcode(opcode), .ir_4(ir_4), .ir_5(ir_5), .ir_11(ir_11),

    /* Instruction Memory signals */
    // input lc3b_word i_mem_rdata,
    // output lc3b_word i_mem_address,

    /* Data Memory signals */
    .d_mem_resp(mem_resp), .d_mem_rdata(mem_rdata), .d_mem_address(mem_address),
    .d_mem_wdata(mem_wdata), .d_mem_read(mem_read), .d_mem_write(mem_write),
    .d_mem_byte_enable(mem_byte_enable)
);





endmodule : mp0
