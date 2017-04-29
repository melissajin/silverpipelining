import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module hazard_detection
(
    input clk,

    /* inputs */
    input lc3b_word mem_address_IF, mem_address_WB,
    input logic br_enable,
    input logic i_mem_resp, d_mem_resp,
    input logic d_mem_read, d_mem_write,
    input logic MEM_inter_read, MEM_inter_write,
    input lc3b_opcode op_IF, op_ID, op_EX, op_MEM, op_MEM_inter, op_WB,
    input lc3b_nzp nzp_IF, nzp_ID, nzp_EX, nzp_MEM, nzp_WB,
    input prediction_WB_out,

    /* outputs */
    output logic load, load_pc, load_pcbak, load_mem_wb_force,
    output logic control_instruc_ident_wb,
    output logic flush, flush_mem_op,
    output logic i_mem_read,

    // Perfomance counter outputs
    output logic bpredicts_inc, bmispredicts_inc, stalls_inc,
    output logic prediction_out,
    output logic taken_out, not_taken_out
);

logic mem_op;
logic br_instruction, taken, not_taken;
logic prediction;

assign load_pcbak = 1'b0;

assign mem_op = (d_mem_read | d_mem_write);
assign stalls_inc = ~load;

assign br_instruction = (op_IF == op_br && nzp_IF != 3'b000);
assign taken_out = taken;
assign not_taken_out = not_taken;
assign prediction_out = prediction;

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
            load = 1'b1;
            load_pc = 1'b1;
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
            load = 1'b1;
            load_pc = 1'b1;
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

    flush = 1'b0;
    flush_mem_op = 1'b0;
    bpredicts_inc = 1'b0;
    bmispredicts_inc = 1'b0;
    case (op_WB)
        op_br: begin
            if(br_enable & (prediction_WB_out == 1'b0 && taken == 1'b1)) begin
                load_pc = 1'b1;
                flush = 1'b1;
                flush_mem_op = 1'b1;
                bmispredicts_inc = 1'b1;
              end
            else if(br_enable == 1'b0 && nzp_WB != 3'b000 && prediction_WB_out == 1'b1 && not_taken == 1'b1) begin
                load_pc = 1'b1;
                flush = 1'b1;
                flush_mem_op = 1'b1;
                bmispredicts_inc = 1'b1;
            end
            else if(nzp_WB != 3'b000) begin
                bpredicts_inc = 1'b1;
            end
        end
        op_jmp: load_pc = 1'b1;
        op_jsr: load_pc = 1'b1;
        op_trap: load_pc = 1'b1;
        default: ;
    endcase

    if(i_mem_read == 1'b0 && control_instruc_ident_wb != 1'b1)
        load_pc = 1'b0;

    load_mem_wb_force = 1'b1;
    if(i_mem_resp == 1'b0 && i_mem_read == 1'b1 && ((op_ID == op_br && nzp_ID != 3'b000) || (op_EX == op_br && nzp_EX != 3'b000) || (op_MEM == op_br && nzp_MEM != 3'b000)) && (op_WB != op_br || nzp_WB == 3'b000)) begin
        load = 1'b0;
        load_pc = 1'b0;
        load_mem_wb_force = 1'b0;
    end

end

always_comb begin
    i_mem_read = 1'b1;
    control_instruc_ident_wb = 1'b0;

    case (op_ID)
        op_jmp: i_mem_read = 1'b0;
        op_jsr: i_mem_read = 1'b0;
        op_trap: i_mem_read = 1'b0;
        default: ;
    endcase

    case (op_EX)
        op_jmp: i_mem_read = 1'b0;
        op_jsr: i_mem_read = 1'b0;
        op_trap: i_mem_read = 1'b0;
        default: ;
    endcase

    case (op_MEM)
        op_jmp: i_mem_read = 1'b0;
        op_jsr: i_mem_read = 1'b0;
        op_trap: i_mem_read = 1'b0;
        default: ;
    endcase

    taken = 1'b0;
    not_taken = 1'b0;
    case (op_WB)
        op_br: begin
            if(br_enable) begin
                if(prediction_WB_out == 1'b0) begin
                    i_mem_read = 1'b0;
                    control_instruc_ident_wb = 1'b1;
                end
                taken = 1'b1;
            end
            else if(nzp_WB != 3'b000) begin
                if(prediction_WB_out == 1'b1) begin
                    i_mem_read = 1'b0;
                    control_instruc_ident_wb = 1'b1;
                end
                not_taken = 1'b1;
            end
        end
        op_jmp:begin
            i_mem_read = 1'b0;
            control_instruc_ident_wb = 1'b1;
        end
        op_jsr: begin
            i_mem_read = 1'b0;
            control_instruc_ident_wb = 1'b1;
        end
        op_trap: begin
            i_mem_read = 1'b0;
            control_instruc_ident_wb = 1'b1;
        end
        default: ;
    endcase
end

branch_predictor #(.num_addr_bits(5)) branch_predictor_inst
(
    .clk,

    .mem_address_IF,
    .mem_address_WB,
    .br_instruction,
    .taken,
    .not_taken,
    .prediction
);

endmodule // hazard_detection
