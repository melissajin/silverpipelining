module mux4 #(parameter width = 16) // creates a modular module so that yo can have variable size inputs
(
	input [1:0] sel, 							// selection bit
	input [width - 1:0] a,b,c,d,	// the inputs to select from
	output logic [width - 1:0] f 	// selected output
);


always_comb
begin
    case (sel)
        2'b00: f = a;
        2'b01: f = b;
        2'b10: f = c;
        2'b11: f = d;
        default : f = a;
    endcase
end

endmodule : mux4
