import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module cpu_control
(
    /* Input and output port declarations */
	 input lc3b_opcode opcode, // IR[15:12]
	 input immediate, // IR[5]
	 input branch_enable, // From datapath
	 output lc3b_control_word ctrl
);

always_comb
begin : state_actions
    /* Default output assignments */
	 
	 ctrl.opcode = opcode;
	 ctrl.aluop = alu_add;
	 ctrl.addermux_sel = 1'b0;
	 ctrl.pcmux_sel = 2'b00;
	 ctrl.destmux_sel = 2'b00;
	 ctrl.src2mux_sel = 1'b0;
	 ctrl.regfilemux_sel = 2'b00;
	 ctrl.alumux_sel = 2'b00;
	 ctrl.marmux_sel = 1'b0;
	 ctrl.indirectmux_sel = 1'b0;
	 ctrl.ldb_sel = 1'b0;
	 ctrl.stb_sel = 1'b0;
	 ctrl.adj_sel = 1'b0;
	 
	 ctrl.load_cc = 1'b0;
	 ctrl.load_regfile = 1'b0;
	 ctrl.load_pc = 1'b0;
	 ctrl.load_ir = 1'b0; // Might not need this?
	 
	 ctrl.dmem_read = 1'b0;
	 ctrl.dmem_write = 1'b0;
	 
    /* Actions for each state */
	 case(opcode)
	 
		op_add:
			begin
				if(immediate) // 1: ADDI
					begin
						ctrl.aluop = alu_add;
						ctrl.alumux_sel = 2'b10; // selects imm5
						
						ctrl.destmux_sel = 2'b10; // selects DEST_WB
						ctrl.regfilemux_sel = 2'b00; // selects alu_out
						ctrl.load_regfile = 1'b1;
						ctrl.load_cc = 1'b1;
					end
					
				else // 0: ADDR
					begin
						ctrl.aluop = alu_add;
						ctrl.alumux_sel = 2'b00; // selects src2
						
						ctrl.destmux_sel = 2'b10; // selects DEST_WB
						ctrl.regfilemux_sel = 2'b00; // selects alu_out
						ctrl.load_regfile = 1'b1;
						ctrl.load_cc = 1'b1;
					end
			end
			
		op_and:
			begin
				if(immediate) // 1: ANDI
					begin
						ctrl.aluop = alu_and;
						ctrl.alumux_sel = 2'b10; // selects imm5
						
						ctrl.destmux_sel = 2'b10; // selects DEST_WB
						ctrl.regfilemux_sel = 2'b00; // selects alu_out
						ctrl.load_regfile = 1'b1;
						ctrl.load_cc = 1'b1;
					end
					
				else // 0: ANDR
					begin
						ctrl.aluop = alu_and;
						ctrl.alumux_sel = 2'b00; // selects src2
						
						ctrl.destmux_sel = 2'b10; // selects DEST_WB
						ctrl.regfilemux_sel = 2'b00; // selects alu_out
						ctrl.load_regfile = 1'b1;
						ctrl.load_cc = 1'b1;
					end
			end
			
		op_not:
			begin
				ctrl.aluop = alu_not;
				
				ctrl.destmux_sel = 2'b10; // selects DEST_WB
				ctrl.regfilemux_sel = 2'b00; // selects alu_out
				ctrl.load_regfile = 1'b1;
				ctrl.load_cc = 1'b1;
			end
		
		op_ldr:
			begin
				// Address calculation
				ctrl.adj_sel = 1'b1; // we want to left-shift/sign-extend the offset
				ctrl.alumux_sel = 2'b11; // ADJ6 output
				ctrl.aluop = alu_add;
				
				// Other memory-related logic
				ctrl.marmux_sel = 1'b0; // alu_out
				ctrl.indirectmux_sel = 1'b0; // get output from MAR (this isn't LDI)
				ctrl.ldb_sel = 1'b0; // not LDB
				ctrl.dmem_read = 1'b1;
				
				// Register file loading
				ctrl.regfilemux_sel = 2'b01; // grab from MDR_WB
				ctrl.destmux_sel = 2'b10; // selects DEST_WB
				load_regfile = 1'b1;
				load_cc = 1'b1;
			end
		
		op_str:
			begin
				// Address calculation
				ctrl.adj_sel = 1'b1; // we want to left-shift/sign-extend the offset
				ctrl.alumux_sel = 2'b11; // ADJ6 output
				ctrl.aluop = alu_add;
				
				// Other memory-related logic
				ctrl.marmux_sel = 1'b0; // alu_out
				ctrl.indirectmux_sel = 1'b0; // get output from MAR (this isn't LDI)
				ctrl.src2mux_sel = 1'b1; // SR is where DR usually is
				ctrl.stb_sel = 1'b0; // not STB
				ctrl.dmem_write = 1'b1;
			end
		
		op_br:
			begin
				if(branch_enable) // Not sure about this- does the timing work out?
					begin
						ctrl.addermux_sel = 1'b0; // SEXT(offset9)
						ctrl.pcmux_sel = 2'b01; // select PC_EX + SEXT(offset9)
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
