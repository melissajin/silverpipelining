
import lc3b_types::*;

module forwarding_unit
(
    input lc3b_forward_ex forward_EX,
	output logic [1:0] forward_a_EX_sel,
	output logic [1:0] forward_b_EX_sel
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

endmodule : forwarding_unit
