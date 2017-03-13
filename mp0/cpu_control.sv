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
    /* Default output assignments */

	 cw.opcode = opcode;
	 cw.aluop = alu_add;
	 cw.addermux_sel = 1'b0;
	 cw.pcmux_sel = 2'b00;
	 cw.destmux_sel = 2'b00;
	 cw.src2mux_sel = 1'b0;
	 cw.regfilemux_sel = 2'b00;
	 cw.alumux_sel = 2'b00;
	 cw.marmux_sel = 1'b0;
	 cw.indirectmux_sel = 1'b0;
	 cw.ldb_sel = 1'b0;
	 cw.stb_sel = 1'b0;
	 cw.adj_sel = 1'b0;

	 cw.load_cc = 1'b0;
	 cw.load_regfile = 1'b0;
	 cw.load_pc = 1'b0;
	 cw.load_ir = 1'b0; // Might not need this?

	 cw.dmem_read = 1'b0;
	 cw.dmem_write = 1'b0;

    /* Actions for each state */
	 case(opcode)

		op_add:
			begin
				if(immediate) // 1: ADDI
					begin
						cw.aluop = alu_add;
						cw.alumux_sel = 2'b10; // selects imm5

						cw.destmux_sel = 2'b10; // selects DEST_WB
						cw.regfilemux_sel = 2'b00; // selects alu_out
						cw.load_regfile = 1'b1;
						cw.load_cc = 1'b1;
					end

				else // 0: ADDR
					begin
						cw.aluop = alu_add;
						cw.alumux_sel = 2'b00; // selects src2

						cw.destmux_sel = 2'b10; // selects DEST_WB
						cw.regfilemux_sel = 2'b00; // selects alu_out
						cw.load_regfile = 1'b1;
						cw.load_cc = 1'b1;
					end
			end

		op_and:
			begin
				if(immediate) // 1: ANDI
					begin
						cw.aluop = alu_and;
						cw.alumux_sel = 2'b10; // selects imm5

						cw.destmux_sel = 2'b10; // selects DEST_WB
						cw.regfilemux_sel = 2'b00; // selects alu_out
						cw.load_regfile = 1'b1;
						cw.load_cc = 1'b1;
					end

				else // 0: ANDR
					begin
						cw.aluop = alu_and;
						cw.alumux_sel = 2'b00; // selects src2

						cw.destmux_sel = 2'b10; // selects DEST_WB
						cw.regfilemux_sel = 2'b00; // selects alu_out
						cw.load_regfile = 1'b1;
						cw.load_cc = 1'b1;
					end
			end

		op_not:
			begin
				cw.aluop = alu_not;

				cw.destmux_sel = 2'b10; // selects DEST_WB
				cw.regfilemux_sel = 2'b00; // selects alu_out
				cw.load_regfile = 1'b1;
				cw.load_cc = 1'b1;
			end

		op_ldr:
			begin
				// Address calculation
				cw.adj_sel = 1'b1; // we want to left-shift/sign-extend the offset
				cw.alumux_sel = 2'b11; // ADJ6 output
				cw.aluop = alu_add;

				// Other memory-related logic
				cw.marmux_sel = 1'b0; // alu_out
				cw.indirectmux_sel = 1'b0; // get output from MAR (this isn't LDI)
				cw.ldb_sel = 1'b0; // not LDB
				cw.dmem_read = 1'b1;

				// Register file loading
				cw.regfilemux_sel = 2'b01; // grab from MDR_WB
				cw.destmux_sel = 2'b10; // selects DEST_WB
				load_regfile = 1'b1;
				load_cc = 1'b1;
			end

		op_str:
			begin
				// Address calculation
				cw.adj_sel = 1'b1; // we want to left-shift/sign-extend the offset
				cw.alumux_sel = 2'b11; // ADJ6 output
				cw.aluop = alu_add;

				// Other memory-related logic
				cw.marmux_sel = 1'b0; // alu_out
				cw.indirectmux_sel = 1'b0; // get output from MAR (this isn't LDI)
				cw.src2mux_sel = 1'b1; // SR is where DR usually is
				cw.stb_sel = 1'b0; // not STB
				cw.dmem_write = 1'b1;
			end

		op_br:
			begin
				if(branch_enable) // Not sure about this- does the timing work out?
					begin
						cw.addermux_sel = 1'b0; // SEXT(offset9)
						cw.pcmux_sel = 2'b01; // select PC_EX + SEXT(offset9)
						load_pc = 1'b1;
					end

				else
					begin ; end // nothing
			end

		default:
			begin ; end // nothing

	 endcase

end

endmodule : cpu_control
