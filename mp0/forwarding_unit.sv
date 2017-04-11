
import lc3b_types::*;

module forwarding_unit
(
    input lc3b_forward_ex forward_EX,
    input lc3b_forward_mem forward_MEM,
	output logic [1:0] forward_a_EX_sel,
	output logic [1:0] forward_b_EX_sel,
    output logic forward_MEM_data_sel,
    output logic forward_MEM_addr_sel
);

always_comb
begin
	forward_a_EX_sel = 2'b00;
	forward_b_EX_sel = 2'b00;
	// WB hazard
	if(forward_EX.load_regfile_wb && (forward_EX.dest_wb == forward_EX.src1_ex))
		forward_a_EX_sel = 2'b10;
	if(forward_EX.load_regfile_wb && (forward_EX.dest_wb == forward_EX.src2_ex))
		forward_b_EX_sel = 2'b10;
	// MEM hazard
	if(forward_EX.load_regfile_mem && (forward_EX.dest_mem == forward_EX.src1_ex))
		forward_a_EX_sel = 2'b01;
	if(forward_EX.load_regfile_mem && (forward_EX.dest_mem == forward_EX.src2_ex))
		forward_b_EX_sel = 2'b01;
end

always_comb
begin
	forward_MEM_data_sel = 1'b0;
    forward_MEM_addr_sel = 1'b0;
	// WB hazard
	if(forward_MEM.load_regfile_wb && (forward_MEM.dest_wb == forward_MEM.sourceR_mem))
		forward_MEM_data_sel = 1'b1;

    if(forward_MEM.load_regfile_wb && (forward_MEM.dest_wb == forward_MEM.baseR_mem))
		forward_MEM_addr_sel = 1'b1;
end

endmodule : forwarding_unit
