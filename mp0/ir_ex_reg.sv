import lc3b_types::*;

module ir_ex_reg
(
    input clk,
    input load,
    input lc3b_ir_10_0 in,
    output lc3b_imm4 imm4,
    output lc3b_imm5 imm5,
    output lc3b_offset6 offset6,
    output lc3b_trapvect8 trapVect8,
    output lc3b_offset11 offset11
);

lc3b_word data;

always_ff @(posedge clk)
begin
    if (load == 1)
    begin
        data = in;
    end
end

always_comb
begin
    imm4 = data[3:0];
    imm5 = data[4:0];
    offset6 = data[5:0];
    trapVect8 = data[7:0];
    offset11 = data[10:0];

end

endmodule : ir_ex_reg
