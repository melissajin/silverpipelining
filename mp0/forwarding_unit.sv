
import lc3b_types::*;

module forwarding_unit
(
    input lc3b_forward_ex forward_EX,
    input lc3b_forward_mem forward_MEM,
    input lc3b_forward_save forward_save,
    input logic indirectmux_sel,
    input lc3b_word address_MEM,
    input lc3b_word address_WB,
    input logic d_mem_write_WB,
    input logic d_mem_resp,
    input logic unstall,
	output logic [1:0] forward_a_EX_sel,
	output logic [1:0] forward_b_EX_sel,
    output logic [1:0] forward_MEM_data_sel,
    output logic forward_MEM_addr_sel,
    output logic stall, unstall_mem_wb
);

always_comb
begin
	forward_a_EX_sel = 2'b00;
	forward_b_EX_sel = 2'b00;
  stall = 1'b0;
  unstall_mem_wb = 1'b0;

    // LDI and STI hazard
    if(forward_save.load_regfile_wb && (forward_save.dest_wb == forward_EX.src1_ex))
		forward_a_EX_sel = 2'b11;
	if(forward_save.load_regfile_wb && (forward_save.dest_wb == forward_EX.src2_ex))
		forward_b_EX_sel = 2'b11;

	// WB hazard
	if(forward_EX.load_regfile_wb && (forward_EX.dest_wb == forward_EX.src1_ex))
		forward_a_EX_sel = 2'b10;
	if(forward_EX.load_regfile_wb && (forward_EX.dest_wb == forward_EX.src2_ex))
		forward_b_EX_sel = 2'b10;

  if(forward_EX.load_regfile_mem && (forward_EX.dest_mem == forward_EX.src1_ex))
    forward_a_EX_sel = 2'b01;
  if(forward_EX.load_regfile_mem && (forward_EX.dest_mem == forward_EX.src2_ex))
    forward_b_EX_sel = 2'b01;

	// MEM hazard TODO: Need to stall instead
	if(forward_EX.d_read_mem && ((forward_EX.dest_mem == forward_EX.src1_ex)
      || ((forward_EX.dest_mem == forward_EX.src2_ex) && (forward_EX.opcode == op_add
        || forward_EX.opcode == op_and)))) begin
    stall = 1'b1;
    if(d_mem_resp) begin
      unstall_mem_wb = 1'b1;
    end
  end

  if(unstall) begin
    stall = 1'b0;
  end
end

always_comb
begin
	forward_MEM_data_sel = 2'b00;
    forward_MEM_addr_sel = 1'b0;

    // LDI/STI hazard
    if(indirectmux_sel & forward_save.load_regfile_wb && forward_save.dest_wb == forward_MEM.sourceR_mem)
		forward_MEM_data_sel = 2'b10;

	// WB hazard
	if(forward_MEM.load_regfile_wb && (~indirectmux_sel) && forward_MEM.dest_wb == forward_MEM.sourceR_mem)
		forward_MEM_data_sel = 2'b01;

    if(forward_MEM.load_regfile_wb && (forward_MEM.dest_wb == forward_MEM.baseR_mem))
		forward_MEM_addr_sel = 1'b1;
end

endmodule : forwarding_unit
