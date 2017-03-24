import lc3b_types::*;

module l2_cache_writelogic
(
    input pmem_read,
    input lc3b_cacheline pmem_rdata, l1_wdata,
    output lc3b_cacheline output_cacheline
);

always_comb begin
    case (pmem_read)
        1'b0: output_cacheline = l1_wdata;
        1'b1: output_cacheline = pmem_rdata;
        default:;
    endcase
end

endmodule : l2_cache_writelogic
