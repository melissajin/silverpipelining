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
    output lc3b_word d_mem_wdata,

    /* Performance counter signals */
    input lc3b_word l2hits_out, l2misses_out, dl1hits_out,
    input lc3b_word dl1misses_out, il1hits_out, il1misses_out,
    input lc3b_word bpredicts_out, bmispredicts_out, stalls_out,
    output logic [8:0] counter_clear_vec
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
    .d_mem_read, .d_mem_write, .d_mem_byte_enable,

    /* Peformance counter signals */
    .l2hits_out, .l2misses_out, .dl1hits_out, .dl1misses_out, .il1hits_out,
    .il1misses_out, .bpredicts_out, .bmispredicts_out, .stalls_out,
    .counter_clear_vec
);





endmodule : cpu
