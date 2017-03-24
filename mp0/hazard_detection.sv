import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module hazard_detection
(
    /* inputs */
    input logic br_enable,
    input logic i_mem_resp, d_mem_resp,
    input logic d_mem_read, d_mem_write,
    input logic MEM_inter_read, MEM_inter_write,
    input lc3b_opcode op_MEM, op_MEM_inter, op_WB,

    /* outputs */
    output logic load, load_pc, load_pcbak
);

logic mem_op;

assign mem_op = (d_mem_read | d_mem_write);

always_comb begin
    case ({i_mem_resp, d_mem_resp, mem_op})
        3'b000: begin
            load = 1'b1;
            load_pc = 1'b0;
        end
        3'b001: begin
            load = 1'b0;
            load_pc = 1'b0;
        end
        3'b010: begin
            load = 1'b0;
            load_pc = 1'b0;
        end
        3'b011: begin
            load = 1'b1;
            load_pc = 1'b0;
        end
        3'b100: begin
            load = 1'b1;
            load_pc = 1'b1;
        end
        3'b101: begin
            load = 1'b0;
            load_pc = 1'b0;
        end
        3'b110: begin
            load = 1'b0;
            load_pc = 1'b0;
        end
        3'b111: begin
            load = 1'b1;
            load_pc = 1'b1;
        end
        default: begin
            load = 1'b1;
            load_pc = 1'b1;
        end
    endcase

    if((op_MEM == op_ldi || op_MEM == op_sti)) begin
        load = 1'b0;
        load_pc = 1'b0;
    end

    if((op_MEM_inter == op_ldi || op_MEM_inter == op_sti) && ({MEM_inter_read, MEM_inter_write} == 2'b00) && d_mem_resp) begin
        load = 1'b1;
        if(i_mem_resp)
            load_pc = 1'b1;
        else
            load_pc = 1'b0;
    end
end

always_comb begin
    load_pcbak = load_pc;
    case (op_WB)
        op_br: begin
            if(br_enable)
                load_pcbak = 1'b1;
        end
        op_jmp: load_pcbak = 1'b1;
        op_jsr: load_pcbak = 1'b1;
        op_trap: load_pcbak = 1'b1;
        default: ;
    endcase
end


endmodule // hazard_detection
