module mux2 #(parameter width = 16) // creates a modular module so that yo can have variable size inputs
(
	input sel, 							// selection bit
	input [width - 1:0] a,b,		// the inputs to select from
	output logic [width - 1:0] f 	// selected output	
);


always_comb
begin
	if(sel == 0)
		f = a;
	else
		f = b;
end

endmodule : mux2
