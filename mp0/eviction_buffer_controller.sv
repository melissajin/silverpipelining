import lc3b_types::*;

module eviction_buffer_controller
(
    input clk,

    // control signals
    input lc3b_7b_plru lru_in,
    input lc3b_eviction_array_entry data_array [7:0],
    input hits [7:0],
    output logic load_d,
    output logic load_lru,
    output lc3b_7b_plru lru_out,
    output logic valid,
    output logic dirty,
    output logic [2:0] index_sel,
    output logic read_src_sel, write_sel,
    output logic [3:0] smemaddr_sel,

    // signals to lower level memory
    input buf_mem_read, buf_mem_write,
    output logic buf_mem_resp,

    // signals to higher level memory
    input super_mem_resp,
    output logic super_mem_read, super_mem_write
);

/* List of states */
enum int unsigned {
    process_request, fetch_cline, return_cline, write_back, buffer, buffer_2
} state, next_state;

logic hit_any, dirty_any;
logic [2:0] lru_sel;

assign hit_any = hits[0] | hits[1] | hits[2] | hits[3] | hits[4] | hits[5] | hits[6] | hits[7];

always_comb
begin : state_actions
    /* Default output assignments */
    index_sel = 0; smemaddr_sel = 8; read_src_sel = 0; write_sel = 0;
    buf_mem_resp = 0; super_mem_read = 0; super_mem_write = 0;
	lru_out = lru_in; load_d = 0; load_lru = 0;

    valid = data_array[0].valid;
    dirty = data_array[0].dirty;

    case (state)
        process_request: begin
            if(hits[0] & (buf_mem_read)) begin
                lru_out = {lru_in[6], lru_in[5], lru_in[4], 1'b1, lru_in[2], 1'b1, 1'b1};
                load_lru = 1;
                buf_mem_resp = 1;
	            index_sel = 0;
                valid = 0;
                dirty = 0;
                load_d = 1;
            end
            if(hits[1] & (buf_mem_read)) begin
                lru_out = {lru_in[6], lru_in[5], lru_in[4], 1'b0, lru_in[2], 1'b1, 1'b1};
                load_lru = 1;
                buf_mem_resp = 1;
 	            index_sel = 1;
                valid = 0;
                dirty = 0;
                load_d = 1;
            end
            if(hits[2] & (buf_mem_read)) begin
                lru_out = {lru_in[6], lru_in[5], 1'b1, lru_in[3], lru_in[2], 1'b0, 1'b1};
                load_lru = 1;
                buf_mem_resp = 1;
                index_sel = 2;
                valid = 0;
                dirty = 0;
                load_d = 1;
            end
            if(hits[3] & (buf_mem_read)) begin
                lru_out = {lru_in[6], lru_in[5], 1'b0, lru_in[3], lru_in[2], 1'b0, 1'b1};
                load_lru = 1;
                buf_mem_resp = 1;
                index_sel = 3;
                valid = 0;
                dirty = 0;
                load_d = 1;
            end
            if(hits[4] & (buf_mem_read)) begin
                lru_out = {lru_in[6], 1'b1, lru_in[4], lru_in[3], 1'b1, lru_in[1], 1'b0};
                load_lru = 1;
                buf_mem_resp = 1;
                index_sel = 4;
                valid = 0;
                dirty = 0;
                load_d = 1;
            end
            if(hits[5] & (buf_mem_read)) begin
                lru_out = {lru_in[6], 1'b0, lru_in[4], lru_in[3], 1'b1, lru_in[1], 1'b0};
                load_lru = 1;
                buf_mem_resp = 1;
                index_sel = 5;
                valid = 0;
                dirty = 0;
                load_d = 1;
            end
            if(hits[6] & (buf_mem_read)) begin
                lru_out = {1'b1, lru_in[5], lru_in[4], lru_in[3], 1'b0, lru_in[1], 1'b0};
                load_lru = 1;
                buf_mem_resp = 1;
                index_sel = 6;
                valid = 0;
                dirty = 0;
                load_d = 1;
            end
            if(hits[7] & (buf_mem_read)) begin
                lru_out = {1'b0, lru_in[5], lru_in[4], lru_in[3], 1'b0, lru_in[1], 1'b0};
                load_lru = 1;
                buf_mem_resp = 1;
                index_sel = 7;
                valid = 0;
                dirty = 0;
                load_d = 1;
            end
            if(buf_mem_write) begin
                buf_mem_resp = 1;
                index_sel = lru_sel;
                write_sel = 1;
                load_lru = 1;
                load_d = 1;
                dirty = 1;
                valid = 1;
                case(lru_sel)
                    3'b000: lru_out = {lru_in[6], lru_in[5], lru_in[4], 1'b1, lru_in[2], 1'b1, 1'b1};
                    3'b001: lru_out = {lru_in[6], lru_in[5], lru_in[4], 1'b0, lru_in[2], 1'b1, 1'b1};
                    3'b010: lru_out = {lru_in[6], lru_in[5], 1'b1, lru_in[3], lru_in[2], 1'b0, 1'b1};
                    3'b011: lru_out = {lru_in[6], lru_in[5], 1'b0, lru_in[3], lru_in[2], 1'b0, 1'b1};
                    3'b100: lru_out = {lru_in[6], 1'b1, lru_in[4], lru_in[3], 1'b1, lru_in[1], 1'b0};
                    3'b101: lru_out = {lru_in[6], 1'b0, lru_in[4], lru_in[3], 1'b1, lru_in[1], 1'b0};
                    3'b110: lru_out = {1'b1, lru_in[5], lru_in[4], lru_in[3], 1'b0, lru_in[1], 1'b0};
                    3'b111: lru_out = {1'b0, lru_in[5], lru_in[4], lru_in[3], 1'b0, lru_in[1], 1'b0};
                endcase
            end
        end
        fetch_cline: begin
            super_mem_read = 1;
            smemaddr_sel = 8;
        end
        return_cline: begin
            buf_mem_resp = 1;
            read_src_sel = 1;
        end
        write_back: begin
            super_mem_write = 1;
            if(data_array[0].dirty) begin
                index_sel = 0;
            end
            if(data_array[1].dirty) begin
                index_sel = 1;
            end
            if(data_array[2].dirty) begin
                index_sel = 2;
            end
            if(data_array[3].dirty) begin
                index_sel = 3;
            end
            if(data_array[4].dirty) begin
                index_sel = 4;
            end
            if(data_array[5].dirty) begin
                index_sel = 5;
            end
            if(data_array[6].dirty) begin
                index_sel = 6;
            end
            if(data_array[7].dirty) begin
                index_sel = 7;
            end
            smemaddr_sel = {1'b0, index_sel};
            write_sel = 0;
            if(super_mem_resp) begin
                load_d = 1;
                valid = 1;
                dirty = 0;
            end
        end
        default:;
    endcase
end

always_comb
begin : next_state_logic
    next_state = state;

    case (state)
        process_request: begin
            if(~(hit_any) & buf_mem_read) begin
                next_state = fetch_cline;
            end else if(buf_mem_write) begin
                next_state = buffer;
            end else if(dirty_any) begin
                next_state = write_back;
            end
        end
        fetch_cline: begin
            if(super_mem_resp == 1)
                next_state = return_cline;
        end
        write_back: begin
            if(super_mem_resp == 1)
                next_state = process_request;
        end
        buffer: begin
            next_state = buffer_2;
        end
        default: next_state = process_request;
    endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
    state <= next_state;
end

always_comb begin
    case(index_sel)
        3'b000: begin
            dirty_any = dirty | data_array[1].dirty | data_array[2].dirty
                | data_array[3].dirty | data_array[4].dirty | data_array[5].dirty | data_array[6].dirty | data_array[7].dirty;
        end
        3'b001: begin
            dirty_any = data_array[0].dirty | dirty | data_array[2].dirty
                | data_array[3].dirty | data_array[4].dirty | data_array[5].dirty | data_array[6].dirty | data_array[7].dirty;
        end
        3'b010: begin
            dirty_any = data_array[0].dirty | data_array[1].dirty | dirty
                | data_array[3].dirty | data_array[4].dirty | data_array[5].dirty | data_array[6].dirty | data_array[7].dirty;
        end
        3'b011: begin
            dirty_any = data_array[0].dirty | data_array[1].dirty | data_array[2].dirty
                | dirty | data_array[4].dirty | data_array[5].dirty | data_array[6].dirty | data_array[7].dirty;
        end
        3'b100: begin
            dirty_any = data_array[0].dirty | data_array[1].dirty | data_array[2].dirty
                | data_array[3].dirty | dirty | data_array[5].dirty | data_array[6].dirty | data_array[7].dirty;
        end
        3'b101: begin
            dirty_any = data_array[0].dirty | data_array[1].dirty | data_array[2].dirty
                | data_array[3].dirty | data_array[4].dirty | dirty | data_array[6].dirty | data_array[7].dirty;
        end
        3'b110: begin
            dirty_any = data_array[0].dirty | data_array[1].dirty | data_array[2].dirty
                | data_array[3].dirty | data_array[4].dirty | data_array[5].dirty | dirty | data_array[7].dirty;
        end
        3'b111: begin
            dirty_any = data_array[0].dirty | data_array[1].dirty | data_array[2].dirty
                | data_array[3].dirty | data_array[4].dirty | data_array[5].dirty | data_array[6].dirty | dirty;
        end
    endcase
end

always_comb begin
    case({lru_in[0], lru_in[1], lru_in[2], lru_in[3], lru_in[4], lru_in[5], lru_in[6]})
        7'b0000000: lru_sel = 3'b000;
        7'b0000001: lru_sel = 3'b000;
        7'b0000010: lru_sel = 3'b000;
        7'b0000011: lru_sel = 3'b000;
        7'b0000100: lru_sel = 3'b000;
        7'b0000101: lru_sel = 3'b000;
        7'b0000110: lru_sel = 3'b000;
        7'b0000111: lru_sel = 3'b000;
        7'b0001000: lru_sel = 3'b001;
        7'b0001001: lru_sel = 3'b001;
        7'b0001010: lru_sel = 3'b001;
        7'b0001011: lru_sel = 3'b001;
        7'b0001100: lru_sel = 3'b001;
        7'b0001101: lru_sel = 3'b001;
        7'b0001110: lru_sel = 3'b001;
        7'b0001111: lru_sel = 3'b001;
        7'b0010000: lru_sel = 3'b000;
        7'b0010001: lru_sel = 3'b000;
        7'b0010010: lru_sel = 3'b000;
        7'b0010011: lru_sel = 3'b000;
        7'b0010100: lru_sel = 3'b000;
        7'b0010101: lru_sel = 3'b000;
        7'b0010110: lru_sel = 3'b000;
        7'b0010111: lru_sel = 3'b000;
        7'b0011000: lru_sel = 3'b001;
        7'b0011001: lru_sel = 3'b001;
        7'b0011010: lru_sel = 3'b001;
        7'b0011011: lru_sel = 3'b001;
        7'b0011100: lru_sel = 3'b001;
        7'b0011101: lru_sel = 3'b001;
        7'b0011110: lru_sel = 3'b001;
        7'b0011111: lru_sel = 3'b001;
        7'b0100000: lru_sel = 3'b010;
        7'b0100001: lru_sel = 3'b010;
        7'b0100010: lru_sel = 3'b010;
        7'b0100011: lru_sel = 3'b010;
        7'b0100100: lru_sel = 3'b011;
        7'b0100101: lru_sel = 3'b011;
        7'b0100110: lru_sel = 3'b011;
        7'b0100111: lru_sel = 3'b011;
        7'b0101000: lru_sel = 3'b010;
        7'b0101001: lru_sel = 3'b010;
        7'b0101010: lru_sel = 3'b010;
        7'b0101011: lru_sel = 3'b010;
        7'b0101100: lru_sel = 3'b011;
        7'b0101101: lru_sel = 3'b011;
        7'b0101110: lru_sel = 3'b011;
        7'b0101111: lru_sel = 3'b011;
        7'b0110000: lru_sel = 3'b010;
        7'b0110001: lru_sel = 3'b010;
        7'b0110010: lru_sel = 3'b010;
        7'b0110011: lru_sel = 3'b010;
        7'b0110100: lru_sel = 3'b011;
        7'b0110101: lru_sel = 3'b011;
        7'b0110110: lru_sel = 3'b011;
        7'b0110111: lru_sel = 3'b011;
        7'b0111000: lru_sel = 3'b010;
        7'b0111001: lru_sel = 3'b010;
        7'b0111010: lru_sel = 3'b010;
        7'b0111011: lru_sel = 3'b010;
        7'b0111100: lru_sel = 3'b011;
        7'b0111101: lru_sel = 3'b011;
        7'b0111110: lru_sel = 3'b011;
        7'b0111111: lru_sel = 3'b011;
        7'b1000000: lru_sel = 3'b100;
        7'b1000001: lru_sel = 3'b100;
        7'b1000010: lru_sel = 3'b101;
        7'b1000011: lru_sel = 3'b101;
        7'b1000100: lru_sel = 3'b100;
        7'b1000101: lru_sel = 3'b100;
        7'b1000110: lru_sel = 3'b101;
        7'b1000111: lru_sel = 3'b101;
        7'b1001000: lru_sel = 3'b100;
        7'b1001001: lru_sel = 3'b100;
        7'b1001010: lru_sel = 3'b101;
        7'b1001011: lru_sel = 3'b101;
        7'b1001100: lru_sel = 3'b100;
        7'b1001101: lru_sel = 3'b100;
        7'b1001110: lru_sel = 3'b101;
        7'b1001111: lru_sel = 3'b101;
        7'b1010000: lru_sel = 3'b110;
        7'b1010001: lru_sel = 3'b111;
        7'b1010010: lru_sel = 3'b110;
        7'b1010011: lru_sel = 3'b111;
        7'b1010100: lru_sel = 3'b110;
        7'b1010101: lru_sel = 3'b111;
        7'b1010110: lru_sel = 3'b110;
        7'b1010111: lru_sel = 3'b111;
        7'b1011000: lru_sel = 3'b110;
        7'b1011001: lru_sel = 3'b111;
        7'b1011010: lru_sel = 3'b110;
        7'b1011011: lru_sel = 3'b111;
        7'b1011100: lru_sel = 3'b110;
        7'b1011101: lru_sel = 3'b111;
        7'b1011110: lru_sel = 3'b110;
        7'b1011111: lru_sel = 3'b111;
        7'b1100000: lru_sel = 3'b100;
        7'b1100001: lru_sel = 3'b100;
        7'b1100010: lru_sel = 3'b101;
        7'b1100011: lru_sel = 3'b101;
        7'b1100100: lru_sel = 3'b100;
        7'b1100101: lru_sel = 3'b100;
        7'b1100110: lru_sel = 3'b101;
        7'b1100111: lru_sel = 3'b101;
        7'b1101000: lru_sel = 3'b100;
        7'b1101001: lru_sel = 3'b100;
        7'b1101010: lru_sel = 3'b101;
        7'b1101011: lru_sel = 3'b101;
        7'b1101100: lru_sel = 3'b100;
        7'b1101101: lru_sel = 3'b100;
        7'b1101110: lru_sel = 3'b101;
        7'b1101111: lru_sel = 3'b101;
        7'b1110000: lru_sel = 3'b110;
        7'b1110001: lru_sel = 3'b111;
        7'b1110010: lru_sel = 3'b110;
        7'b1110011: lru_sel = 3'b111;
        7'b1110100: lru_sel = 3'b110;
        7'b1110101: lru_sel = 3'b111;
        7'b1110110: lru_sel = 3'b110;
        7'b1110111: lru_sel = 3'b111;
        7'b1111000: lru_sel = 3'b110;
        7'b1111001: lru_sel = 3'b111;
        7'b1111010: lru_sel = 3'b110;
        7'b1111011: lru_sel = 3'b111;
        7'b1111100: lru_sel = 3'b110;
        7'b1111101: lru_sel = 3'b111;
        7'b1111110: lru_sel = 3'b110;
        7'b1111111: lru_sel = 3'b111;
        default : ;
    endcase
end

endmodule : eviction_buffer_controller
