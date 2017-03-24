import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module hazard_detection
(
    /* inputs */
    input logic i_mem_resp, d_mem_resp,
    input logic d_mem_read, d_mem_write,
    input logic MEM_inter_read, MEM_inter_write,
    input lc3b_opcode op_MEM, op_MEM_inter,

    /* outputs */
    output logic load


);

logic mem_op;

assign mem_op = (d_mem_read | d_mem_write);

always_comb begin
    case ({i_mem_resp, d_mem_resp, mem_op})
        3'b000:  load = 1'b1;
        3'b001:  load = 1'b0;
        3'b010:  load = 1'b0;   // TODO: change to 1 once cache has been implemented and tested
        3'b011:  load = 1'b1;
        3'b100:  load = 1'b1;
        3'b101:  load = 1'b0;
        3'b110:  load = 1'b0;   // TODO: change to 1 once cache has been implemented and tested
        3'b111:  load = 1'b1;
        default: load = 1'b1;
    endcase

    if((op_MEM == op_ldi || op_MEM == op_sti)) begin
        load = 1'b0;
    end

    if((op_MEM_inter == op_ldi || op_MEM_inter == op_sti) && ({MEM_inter_read, MEM_inter_write} == 2'b00) && d_mem_resp) begin
        load = 1'b1;
    end
end


endmodule // hazard_detection
