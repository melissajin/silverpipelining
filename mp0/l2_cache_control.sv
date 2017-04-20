import lc3b_types::*;

module l2_cache_control
(
    input clk,

    /* Control signals */
    input logic [6:0] lru_in,
    input lc3b_L2_state way_state,
    output lc3b_L2_ctl ctl,
    output logic [6:0] lru_out,
    output logic [2:0] pmemwdata_sel,
    output logic [3:0] pmemaddr_sel,

    /* Arbiter signals */
    input mem_read, mem_write,
    output logic mem_resp,

    /* Physical Memory signals */
    input pmem_resp,
    input lc3b_word pmem_address_inter,
    input lc3b_cacheline pmem_wdata_inter,
    output logic pmem_read, pmem_write,
    output lc3b_word pmem_address,
    output lc3b_cacheline pmem_wdata,
    output logic eviction
);

/* List of states */
enum int unsigned {
    process_request, fetch_cline, write_back, buffer, buffer_2, evict_cline
} state, next_state;

logic [2:0] lru_sel;
logic hit, dirty_lru, valid_lru;
assign hit = way_state.way0.hit | way_state.way1.hit | way_state.way2.hit | way_state.way3.hit
            | way_state.way4.hit | way_state.way5.hit | way_state.way6.hit | way_state.way7.hit;
assign dirty_lru = (way_state.way0.d_out == 1 && lru_sel == 0) || (way_state.way1.d_out == 1 && lru_sel == 1) ||
                   (way_state.way2.d_out == 1 && lru_sel == 2) || (way_state.way3.d_out == 1 && lru_sel == 3) ||
                   (way_state.way4.d_out == 1 && lru_sel == 4) || (way_state.way5.d_out == 1 && lru_sel == 5) ||
                   (way_state.way6.d_out == 1 && lru_sel == 6) || (way_state.way7.d_out == 1 && lru_sel == 7);

assign valid_lru = (way_state.way0.v_out == 1 && lru_sel == 0) || (way_state.way1.v_out == 1 && lru_sel == 1) ||
                   (way_state.way2.v_out == 1 && lru_sel == 2) || (way_state.way3.v_out == 1 && lru_sel == 3) ||
                   (way_state.way4.v_out == 1 && lru_sel == 4) || (way_state.way5.v_out == 1 && lru_sel == 5) ||
                   (way_state.way6.v_out == 1 && lru_sel == 6) || (way_state.way7.v_out == 1 && lru_sel == 7);

always_comb
begin : state_actions
    /* Default output assignments */
    ctl = 0;
    pmemwdata_sel = 0;
    pmemaddr_sel = 4'h0;
    mem_resp = 0; pmem_read = 0; pmem_write = 0;
	lru_out = lru_in;
    eviction = 0;

    case (state)
        process_request: begin
            if(way_state.way0.hit & (mem_read ^ mem_write)) begin
                if(mem_write) begin
                    ctl.way0.d_in = 1;
                    ctl.way0.load_d = 1;
	                ctl.way0.load_TD = 1;
                end
                lru_out = {lru_in[6], lru_in[5], lru_in[4], 1'b1, lru_in[2], 1'b1, 1'b1};
                ctl.load_lru = 1;
                mem_resp = 1;
	            pmemwdata_sel = 0;
            end
            if(way_state.way1.hit & (mem_read ^ mem_write)) begin
                if(mem_write) begin
                    ctl.way1.d_in = 1;
                    ctl.way1.load_d = 1;
	                ctl.way1.load_TD = 1;
                end
                lru_out = {lru_in[6], lru_in[5], lru_in[4], 1'b0, lru_in[2], 1'b1, 1'b1};
                ctl.load_lru = 1;
                mem_resp = 1;
 	            pmemwdata_sel = 1;
            end
            if(way_state.way2.hit & (mem_read ^ mem_write)) begin
                if(mem_write) begin
                    ctl.way2.d_in = 1;
                    ctl.way2.load_d = 1;
                    ctl.way2.load_TD = 1;
                end
                lru_out = {lru_in[6], lru_in[5], 1'b1, lru_in[3], lru_in[2], 1'b0, 1'b1};
                ctl.load_lru = 1;
                mem_resp = 1;
                pmemwdata_sel = 2;
            end
            if(way_state.way3.hit & (mem_read ^ mem_write)) begin
                if(mem_write) begin
                    ctl.way3.d_in = 1;
                    ctl.way3.load_d = 1;
                    ctl.way3.load_TD = 1;
                end
                lru_out = {lru_in[6], lru_in[5], 1'b0, lru_in[3], lru_in[2], 1'b0, 1'b1};
                ctl.load_lru = 1;
                mem_resp = 1;
                pmemwdata_sel = 3;
            end
            if(way_state.way4.hit & (mem_read ^ mem_write)) begin
                if(mem_write) begin
                    ctl.way4.d_in = 1;
                    ctl.way4.load_d = 1;
                    ctl.way4.load_TD = 1;
                end
                lru_out = {lru_in[6], 1'b1, lru_in[4], lru_in[3], 1'b1, lru_in[1], 1'b0};
                ctl.load_lru = 1;
                mem_resp = 1;
                pmemwdata_sel = 4;
            end
            if(way_state.way5.hit & (mem_read ^ mem_write)) begin
                if(mem_write) begin
                    ctl.way5.d_in = 1;
                    ctl.way5.load_d = 1;
                    ctl.way5.load_TD = 1;
                end
                lru_out = {lru_in[6], 1'b0, lru_in[4], lru_in[3], 1'b1, lru_in[1], 1'b0};
                ctl.load_lru = 1;
                mem_resp = 1;
                pmemwdata_sel = 5;
            end
            if(way_state.way6.hit & (mem_read ^ mem_write)) begin
                if(mem_write) begin
                    ctl.way6.d_in = 1;
                    ctl.way6.load_d = 1;
                    ctl.way6.load_TD = 1;
                end
                lru_out = {1'b1, lru_in[5], lru_in[4], lru_in[3], 1'b0, lru_in[1], 1'b0};
                ctl.load_lru = 1;
                mem_resp = 1;
                pmemwdata_sel = 6;
            end
            if(way_state.way7.hit & (mem_read ^ mem_write)) begin
                if(mem_write) begin
                    ctl.way7.d_in = 1;
                    ctl.way7.load_d = 1;
                    ctl.way7.load_TD = 1;
                end
                lru_out = {1'b0, lru_in[5], lru_in[4], lru_in[3], 1'b0, lru_in[1], 1'b0};
                ctl.load_lru = 1;
                mem_resp = 1;
                pmemwdata_sel = 7;
            end

            // setup for write_back and evict_cline
            if(next_state == write_back || next_state == evict_cline) begin
                pmemwdata_sel = lru_sel;
                pmemaddr_sel = {1'b0, lru_sel}+4'b0001;
            end
        end
        evict_cline: begin
            eviction = 1;

            // setup for feth_cline ... not conditional since victim cache will respond in 1 clk cycle
            pmemaddr_sel = 4'b0000;
        end
        fetch_cline: begin
            pmem_read = 1;
            case(lru_sel)
                3'b000:
                    begin
                        ctl.way0.v_in = 1;
                        ctl.way0.d_in = 0;
                        ctl.way0.load_v = 1;
                        ctl.way0.load_d = 1;
                        ctl.way0.load_TD = 1;
                    end
                3'b001:
                    begin
                        ctl.way1.v_in = 1;
                        ctl.way1.d_in = 0;
                        ctl.way1.load_v = 1;
                        ctl.way1.load_d = 1;
                        ctl.way1.load_TD = 1;
                    end
                3'b010:
                    begin
                        ctl.way2.v_in = 1;
                        ctl.way2.d_in = 0;
                        ctl.way2.load_v = 1;
                        ctl.way2.load_d = 1;
                        ctl.way2.load_TD = 1;
                    end
                3'b011:
                    begin
                        ctl.way3.v_in = 1;
                        ctl.way3.d_in = 0;
                        ctl.way3.load_v = 1;
                        ctl.way3.load_d = 1;
                        ctl.way3.load_TD = 1;
                    end
                3'b100:
                    begin
                        ctl.way4.v_in = 1;
                        ctl.way4.d_in = 0;
                        ctl.way4.load_v = 1;
                        ctl.way4.load_d = 1;
                        ctl.way4.load_TD = 1;
                    end
                3'b101:
                    begin
                        ctl.way5.v_in = 1;
                        ctl.way5.d_in = 0;
                        ctl.way5.load_v = 1;
                        ctl.way5.load_d = 1;
                        ctl.way5.load_TD = 1;
                    end
                3'b110:
                    begin
                        ctl.way6.v_in = 1;
                        ctl.way6.d_in = 0;
                        ctl.way6.load_v = 1;
                        ctl.way6.load_d = 1;
                        ctl.way6.load_TD = 1;
                    end
                3'b111:
                    begin
                        ctl.way7.v_in = 1;
                        ctl.way7.d_in = 0;
                        ctl.way7.load_v = 1;
                        ctl.way7.load_d = 1;
                        ctl.way7.load_TD = 1;
                    end
            endcase
        end
        write_back: begin
            eviction = 1;
            pmem_write = 1;
            pmemwdata_sel = lru_sel;
            pmemaddr_sel = {1'b0, lru_sel}+4'b0001;

            // setup for feth_cline
            if(pmem_resp == 1'b1)
                pmemaddr_sel = 4'b0000;
        end
        default:;
    endcase


end

always_comb
begin : next_state_logic
    next_state = state;

    case (state)
        process_request: begin
            if(~(hit) & (mem_read ^ mem_write)) begin
                if(dirty_lru)
                    next_state = write_back;
                else if(valid_lru)
                    next_state = evict_cline;
                else
                    next_state = fetch_cline;
            end else if(mem_read ^ mem_write) begin
                next_state = buffer;
            end
        end
        evict_cline: begin
            next_state = fetch_cline;
        end
        fetch_cline: begin
            if(pmem_resp == 1)
                next_state = process_request;
        end
        write_back: begin
            if(pmem_resp == 1)
                next_state = fetch_cline;
        end
        buffer: begin
            next_state = buffer_2;
        end
        buffer_2: begin
            next_state = process_request;
        end
        default: next_state = process_request;
    endcase


end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
    state <= next_state;
    pmem_wdata <= pmem_wdata_inter;
    pmem_address <= pmem_address_inter;
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

endmodule : l2_cache_control
