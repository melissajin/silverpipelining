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
logic load_regfile, load_mar, load_mdr, load_cc, storemux_sel;
logic [1:0] marmux_sel, pcmux_sel, regfilemux_sel, alumux_sel, mdrInModifier_sel, mdrOutModifier_sel;
logic mdrmux_sel, addrmux_sel, drmux_sel, offset6_lsse, br_enable, ir_4, ir_5, ir_11;
lc3b_aluop aluop;
lc3b_opcode opcode;


cpu_control control
(
    .clk,

    /* Datapath controls */
    .opcode, .ir_4, .ir_5, .ir_11, .br_enable, .memparity(mem_address[0]), .load_regfile, .load_mar,
    .load_mdr, .load_cc, .pcmux_sel, .storemux_sel, .alumux_sel,
    .regfilemux_sel, .marmux_sel, .mdrmux_sel, .addrmux_sel, .drmux_sel, .offset6_lsse,
    .mdrInModifier_sel, .mdrOutModifier_sel, .aluop,

    /* Memory signals */
    .mem_resp, .mem_read, .mem_write, .mem_byte_enable
);

cpu_datapath datapath
(
    .clk,

    /* Control signals */
    .load_regfile, .load_mar, .load_mdr, .load_cc,
    .pcmux_sel, .storemux_sel, .alumux_sel, .regfilemux_sel, .marmux_sel,
    .mdrmux_sel, .addrmux_sel, .drmux_sel, .offset6_lsse, .mdrInModifier_sel, .mdrOutModifier_sel,
    .aluop, .opcode, .ir_4, .ir_5, .ir_11, .br_enable,

     /* Memory signals */
    .mem_rdata, .mem_address, .mem_wdata
);





endmodule : mp0
