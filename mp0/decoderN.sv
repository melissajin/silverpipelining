module decoder_N #(parameter N = 2)
(
  input logic [N-1:0] a,
  output logic [(1<<N)-1:0] y
);

always_comb begin
  y = 0;
  y[a] = 1;
end

endmodule
