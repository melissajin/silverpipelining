import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module cpu_control
(
    input lc3b_opcode opcode,
    input logic ir_4,
    input logic ir_5,
    input logic ir_11,
    output lc3b_control_word cw
);

always_comb
begin : state_actions
    /************** Default output assignments **************/
    // Stage 2 Signals
    cw.src2mux_sel = 1'b0;

    // Stage 3 Signals
    cw.ex.aluop = alu_pass;
    cw.ex.offset6_lsse = 1'b1;
    cw.ex.marmux_EX_sel = 1'b0;
    cw.ex.alumux_sel = 2'b00;
    cw.ex.mdrmux_EX_sel = 2'b00;

    // Stage 4 Signals
    cw.mem.indirectmux_sel = 1'b0;
    cw.mem.load_pipe_mem = 1'b1;
    cw.mem.d_mem_read = 1'b0;
    cw.mem.d_mem_write = 1'b0;

    // Stage 5 Signals
    cw.wb.opcode = opcode;
    cw.wb.addrmux_sel = 1'b0;
    cw.wb.destmux_sel = 1'b0;
    cw.wb.pcmux_sel = 2'b00;
    cw.wb.mdrmux_WB_sel = 2'b00;
    cw.wb.regfilemux_sel = 2'b00;
    cw.wb.load_pipe_wb = 1'b1;
    cw.wb.load_cc = 1'b0;
    cw.wb.load_regfile = 1'b0;
    cw.wb.load_pc = 1'b0;
    cw.wb.load_ir = 1'b0;

    case (opcode)
        op_add: begin
            cw.ex.aluop = alu_add;
            cw.wb.destmux_sel = 1'b0;           // selects DEST_WB
            cw.wb.regfilemux_sel = 2'b00;       // selects alu_WB_out
            cw.wb.load_regfile = 1'b1;
            cw.wb.load_cc = 1'b1;
            if(ir_5)
                cw.ex.alumux_sel= 2'b10;        // selects imm5_EX
            else
                cw.ex.alumux_sel= 2'b00;        // selects src2_EX
        end
        op_and: begin
            cw.ex.aluop = alu_and;
            cw.wb.destmux_sel = 1'b0;           // selects DEST_WB
            cw.wb.regfilemux_sel = 2'b00;       // selects alu_WB_out
            cw.wb.load_regfile = 1'b1;
            cw.wb.load_cc = 1'b1;
            if(ir_5)
                cw.ex.alumux_sel= 2'b10;        // selects imm5_EX
            else
                cw.ex.alumux_sel= 2'b00;        // selects src2_EX
        end
        op_not: begin
            cw.ex.aluop = alu_not;
            cw.wb.destmux_sel = 1'b0;           // selects DEST_WB
            cw.wb.regfilemux_sel = 2'b00;       // selects alu_WB_out
            cw.wb.load_regfile = 1'b1;
            cw.wb.load_cc = 1'b1;
        end
        op_ldr: begin
            cw.ex.offset6_lsse = 1'b1;          // we want to left-shift/sign-extend the offset
            cw.ex.alumux_sel= 2'b11;            // ADJ6 output
            cw.ex.aluop = alu_add;
            cw.ex.marmux_EX_sel = 1'b0;         // alu_out

            cw.mem.indirectmux_sel = 1'b0;      // get output from MAR (this isn't LDI)
            cw.mem.load_pipe_mem = 1'b0;
            cw.mem.d_mem_read = 1'b1;

            cw.wb.mdrmux_WB_sel = 2'b00;        // not LDB
            cw.wb.regfilemux_sel = 2'b01;       // grab from MDR_WB
            cw.wb.destmux_sel = 1'b0;           // selects DEST_WB
            cw.mem.load_pipe_wb = 1'b1;
            cw.wb.load_regfile = 1'b1;
            cw.wb.load_cc = 1'b1;
        end
        op_str: begin
            cw.src2mux_sel = 1'b1;          // we want to left-shift/sign-extend the offset

            cw.ex.offset6_lsse = 1'b1;          // we want to left-shift/sign-extend the offset
            cw.ex.alumux_sel= 2'b11;            // ADJ6 output
            cw.ex.aluop = alu_add;
            cw.ex.marmux_EX_sel = 1'b0;         // alu_out
            cw.ex.mdrmux_EX_sel = 2'b11;        // sr2

            cw.mem.indirectmux_sel = 1'b0;      // get output from MAR (this isn't LDI)
            cw.mem.load_pipe_mem = 1'b0;
            cw.mem.d_mem_write = 1'b1;

            cw.mem.load_pipe_wb = 1'b1;
        end
        op_br: begin
            // Everything is combinational
        end

        default: ;
    endcase



end

endmodule : cpu_control
