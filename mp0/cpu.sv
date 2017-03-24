import lc3b_types::*;

module cpu
(
    input clk,

    /* Instruction Memory signals */
    input i_mem_resp,
    input lc3b_word i_mem_rdata,
    output logic i_mem_read,
    output lc3b_word i_mem_address,

    /* Data Memory signals */
    input d_mem_resp,
    input lc3b_word d_mem_rdata,
    output logic d_mem_read,
    output logic d_mem_write,
    output lc3b_mem_wmask d_mem_byte_enable,
    output lc3b_word d_mem_address,
    output lc3b_word d_mem_wdata
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
    .i_mem_resp, .i_mem_rdata, .i_mem_address, .i_mem_read,

    /* Data Memory signals */
    .d_mem_resp, .d_mem_rdata, .d_mem_address, .d_mem_wdata,
    .d_mem_read, .d_mem_write, .d_mem_byte_enable
);





endmodule : cpu
