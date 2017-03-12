
module adder #(parameter width = 16)
(
	input logic [width-1:0] a, b,
	output logic [width-1:0] c
);

always_comb
begin
	c = a + b;
end

endmodule : adder

