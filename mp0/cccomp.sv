
import lc3b_types::*;

module cccomp
(
	input lc3b_nzp cur_cc, br_cc,
	output logic br_enable
);

	always_comb
	begin
			if (cur_cc & br_cc) begin
				br_enable = 1'b1;
			end else begin
				br_enable = 1'b0;
			end
	end
	
	
endmodule
