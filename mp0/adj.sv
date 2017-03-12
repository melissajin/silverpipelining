import lc3b_types::*;

/*
 * SEXT[offset-n << 1] or SEXT[offset]
 */
module adj #(parameter width = 8)
(
    input lsse,                     // left shifted and sign extended
    input [width-1:0] in,
    output lc3b_word out
);

//assign out = $signed({in, 1'b0});

always_comb
begin
    if(lsse == 1'b1) begin
        out = $signed({in, 1'b0});
    end else begin
        out = $signed(in);
    end
end

endmodule : adj
