
import lc3b_types::*;

module forwarding_unit
(
	input lc3b_reg dest_mem,
	input lc3b_reg dest_wb,
	input lc3b_reg src1_ex,
	input lc3b_reg src2_ex,
	input logic load_regfile_mem,
	input logic load_regfile_wb,
	output logic [1:0] forward_a_sel,
	output logic [1:0] forward_b_sel				
);

always_comb
begin
	forward_a_sel = 2'b00;
	forward_b_sel = 2'b00;
	// EX hazard
	if(load_regfile_mem && (dest_mem != 0) && (dest_mem == src1_ex))
		forward_a_sel = 2'b10;
	if(load_regfile_mem && (dest_mem != 0) && (dest_mem == src2_ex))
		forward_b_sel = 2'b10;
	// MEM hazard
	if(load_regfile_wb && (dest_wb != 0) && (dest_wb == src1_ex))
		forward_a_sel = 2'b01;
	if(load_regfile_wb && (dest_wb != 0) && (dest_wb == src2_ex))
		forward_b_sel = 2'b01;
end

endmodule : forwarding_unit
