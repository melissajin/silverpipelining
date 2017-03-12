module mux8 #(parameter width = 16) // creates a modular module so that yo can have variable size inputs
(
	input [2:0] sel, 									// selection bit
	input [width - 1:0] a,b,c,d,e,f,g,h,      // the inputs to select from
	output logic [width - 1:0] y 	            // selected output
);


always_comb
begin
    case (sel)
        3'b000: y = a;
        3'b001: y = b;
        3'b010: y = c;
        3'b011: y = d;
        3'b100: y = e;
        3'b101: y = f;
        3'b110: y = g;
        3'b111: y = h;
        default : y = a;
    endcase
end

endmodule : mux8
