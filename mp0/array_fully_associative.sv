import lc3b_types::*;

module array_fully_associative #(parameter size = 8)
(
    input clk,
    input write,
    input lc3b_c_index index,
    input lc3b_eviction_array_entry datain,
    output lc3b_eviction_array_entry dataout [size-1:0]
);

lc3b_eviction_array_entry data [size-1:0];

/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 1'b0;
    end
end

/* Storage logic */
always_ff @(posedge clk)
begin
    if (write == 1)
    begin
        data[index] = datain;
    end
end

/* Output logic */
assign dataout = data;

endmodule : array_fully_associative
