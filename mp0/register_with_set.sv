module register_with_set #(parameter width = 16)
(
    input clk,
    input load,
    input set,
    input [width-1:0] in,
    output logic [width-1:0] out
);

logic [width-1:0] data;

/* Altera device registers are 0 at power on. Specify this
 * so that Modelsim works as expected.
 */
initial
begin
    data = 1'b0;
end

always_ff @(posedge clk or posedge set)
begin
    if(set)
      begin
          data = 1;
      end
    else if (load)
      begin
          data = in;
      end
end

always_comb
begin
    out = data;
end

endmodule : register_with_set
