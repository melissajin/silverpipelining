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

    // Stage 4 Signals
    cw.mem.d_mem_read = 1'b0;
    cw.mem.d_mem_write = 1'b0;
    cw.mem.offset6_lsse = 1'b1;
    cw.mem.forward_MEM_sel = 2'b00;

    // Stage 5 Signals
    cw.wb.d_mem_read = 1'b0;
    cw.wb.d_mem_write = 1'b0;
    cw.wb.opcode = opcode;
    cw.wb.destmux_sel = 1'b0;
    cw.wb.regfilemux_sel = 2'b00;
    cw.wb.load_cc = 1'b0;
    cw.wb.load_regfile = 1'b0;
    cw.wb.forward_WB_sel = 2'b00;

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

            // forwarding signals
            cw.mem.forward_MEM_sel = 2'b00;
            cw.wb.forward_WB_sel = 2'b00;
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

            // forwarding signals
            cw.mem.forward_MEM_sel = 2'b00;
            cw.wb.forward_WB_sel = 2'b00;
        end
        op_br: begin
            // Everything is combinational
        end
        op_jmp: begin
            // Everything is combinational
        end
        op_jsr: begin
            cw.wb.regfilemux_sel = 2'b11;       // selects pc_WB_out
            cw.wb.destmux_sel = 1'b1;           // selects R7
            cw.wb.load_regfile = 1'b1;
        end
        op_ldb: begin
            cw.ex.offset6_lsse = 1'b0;          // we want to sign-extend the offset
            cw.mem.offset6_lsse = 1'b0;
            cw.ex.alumux_sel= 2'b11;            // ADJ6 output
            cw.ex.aluop = alu_add;
            cw.ex.marmux_EX_sel = 1'b0;         // alu_out

            cw.mem.d_mem_read = 1'b1;

            cw.wb.regfilemux_sel = 2'b01;       // grab from MDR_WB
            cw.wb.destmux_sel = 1'b0;           // selects DEST_WB
            cw.wb.load_regfile = 1'b1;
            cw.wb.load_cc = 1'b1;

            // forwarding signals
            cw.mem.forward_MEM_sel = 2'b11;
            cw.wb.forward_WB_sel = 2'b11;
        end
        op_ldi: begin
            cw.ex.offset6_lsse = 1'b1;          // we want to left-shift/sign-extend the offset
            cw.mem.offset6_lsse = 1'b1;
            cw.ex.alumux_sel= 2'b11;            // ADJ6 output
            cw.ex.aluop = alu_add;
            cw.ex.marmux_EX_sel = 1'b0;         // alu_out

            cw.mem.d_mem_read = 1'b1;

            cw.wb.d_mem_read = 1'b1;
            cw.wb.regfilemux_sel = 2'b01;       // grab from MDR_WB
            cw.wb.destmux_sel = 1'b0;           // selects DEST_WB
            cw.wb.load_regfile = 1'b1;
            cw.wb.load_cc = 1'b1;

            // forwarding signals
            cw.mem.forward_MEM_sel = 2'b11;
            cw.wb.forward_WB_sel = 2'b11;
        end
        op_ldr: begin
            cw.ex.offset6_lsse = 1'b1;          // we want to left-shift/sign-extend the offset
            cw.mem.offset6_lsse = 1'b1;
            cw.ex.alumux_sel= 2'b11;            // ADJ6 output
            cw.ex.aluop = alu_add;
            cw.ex.marmux_EX_sel = 1'b0;         // alu_out

            cw.mem.d_mem_read = 1'b1;

            cw.wb.regfilemux_sel = 2'b01;       // grab from MDR_WB
            cw.wb.destmux_sel = 1'b0;           // selects DEST_WB
            cw.wb.load_regfile = 1'b1;
            cw.wb.load_cc = 1'b1;

            // forwarding signals
            cw.mem.forward_MEM_sel = 2'b11;
            cw.wb.forward_WB_sel = 2'b11;
        end
        op_lea: begin
            cw.wb.regfilemux_sel = 2'b10;       // selects pc_plus_off
            cw.wb.destmux_sel = 1'b0;           // selects DEST_WB
            cw.wb.load_regfile = 1'b1;
            cw.wb.load_cc = 1'b1;

            // forwarding signals
            cw.mem.forward_MEM_sel = 2'b10;
            cw.wb.forward_WB_sel = 2'b10;
        end
        op_not: begin
            cw.ex.aluop = alu_not;
            cw.wb.destmux_sel = 1'b0;           // selects DEST_WB
            cw.wb.regfilemux_sel = 2'b00;       // selects alu_WB_out
            cw.wb.load_regfile = 1'b1;
            cw.wb.load_cc = 1'b1;

            // forwarding signals
            cw.mem.forward_MEM_sel = 2'b00;
            cw.wb.forward_WB_sel = 2'b00;
        end
        op_shf: begin
            case ({ir_4,ir_5})
                2'b00: cw.ex.aluop = alu_sll;
                2'b01: cw.ex.aluop = alu_sll;
                2'b10: cw.ex.aluop = alu_srl;
                2'b11: cw.ex.aluop = alu_sra;
					default: cw.ex.aluop = alu_pass;
				endcase
				cw.ex.alumux_sel = 2'b01;            // selects imm4_EX
            cw.wb.destmux_sel = 1'b0;           // selects DEST_WB
            cw.wb.regfilemux_sel = 2'b00;       // selects alu_WB_out
            cw.wb.load_regfile = 1'b1;
            cw.wb.load_cc = 1'b1;

            // forwarding signals
            cw.mem.forward_MEM_sel = 2'b00;
            cw.wb.forward_WB_sel = 2'b00;
        end
        op_stb: begin
            cw.src2mux_sel = 1'b1;              // dest

            cw.ex.offset6_lsse = 1'b0;          // we want to sign-extend the offset
            cw.mem.offset6_lsse = 1'b0;
            cw.ex.alumux_sel= 2'b11;            // ADJ6 output
            cw.ex.aluop = alu_add;
            cw.ex.marmux_EX_sel = 1'b0;         // alu_out

            cw.mem.d_mem_write = 1'b1;
        end
        op_sti: begin
            cw.src2mux_sel = 1'b1;              // dest

            cw.ex.offset6_lsse = 1'b1;          // we want to left-shift/sign-extend the offset
            cw.mem.offset6_lsse = 1'b1;
            cw.ex.alumux_sel= 2'b11;            // ADJ6 output
            cw.ex.aluop = alu_add;
            cw.ex.marmux_EX_sel = 1'b0;         // alu_out

            cw.mem.d_mem_read = 1'b1;

            cw.wb.d_mem_write = 1'b1;
        end
        op_str: begin
            cw.src2mux_sel = 1'b1;              // dest

            cw.ex.offset6_lsse = 1'b1;          // we want to left-shift/sign-extend the offset
            cw.mem.offset6_lsse = 1'b1;
            cw.ex.alumux_sel= 2'b11;            // ADJ6 output
            cw.ex.aluop = alu_add;
            cw.ex.marmux_EX_sel = 1'b0;         // alu_out

            cw.mem.d_mem_write = 1'b1;
        end
        op_trap: begin
            cw.ex.marmux_EX_sel = 1'b1;         // trapVect8_EX

            cw.mem.d_mem_read = 1'b1;

            cw.wb.regfilemux_sel = 2'b11;       // grab from pc_WB_out
            cw.wb.destmux_sel = 1'b1;           // selects R7
            cw.wb.load_regfile = 1'b1;
        end
        default: ;
    endcase
end

endmodule : cpu_control
