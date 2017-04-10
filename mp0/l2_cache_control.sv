import lc3b_types::*;

module l2_cache_control
(
    input clk,

    /* Control signals */
    input lc3b_l2_lru lru_in,
    input lc3b_L2_state way_state,
    output lc3b_L2_ctl ctl,
    output lc3b_l2_lru lru_out,
    output logic [1:0] pmemwdata_sel,
    output logic [2:0] pmemaddr_sel,

    /* Arbiter signals */
    input mem_read, mem_write,
    output logic mem_resp,

    /* Physical Memory signals */
    input pmem_resp,
    input lc3b_word pmem_address_inter,
    input lc3b_cacheline pmem_wdata_inter,
    output logic pmem_read, pmem_write,
    output lc3b_word pmem_address,
    output lc3b_cacheline pmem_wdata
);

/* List of states */
enum int unsigned {
    process_request, fetch_cline, write_back, buffer, buffer_2
} state, next_state;

<<<<<<< HEAD
logic [2:0] lru_sel;
=======
logic [1:0] lru_sel;
>>>>>>> master
logic hit, dirty_lru;

assign hit = way_state.way0.hit | way_state.way1.hit | way_state.way2.hit | way_state.way3.hit;
assign dirty_lru = (way_state.way0.d_out == 1 && lru_sel == 0) || (way_state.way1.d_out == 1 && lru_sel == 1)
                   || (way_state.way2.d_out == 1 && lru_sel == 2) || (way_state.way3.d_out == 1 && lru_sel == 3);
always_comb
begin : state_actions
    /* Default output assignments */
    ctl = 0;
    pmemwdata_sel = 0; pmemaddr_sel = 0;
    mem_resp = 0; pmem_read = 0; pmem_write = 0;
<<<<<<< HEAD
	lru_out = lru_in;
=======
    lru_out = lru_in;
>>>>>>> master

    case (state)
        process_request: begin
            if(way_state.way0.hit & (mem_read ^ mem_write)) begin
                if(mem_write) begin
                    ctl.way0.d_in = 1;
                    ctl.way0.load_d = 1;
	                ctl.way0.load_TD = 1;
                end
                lru_out = {lru_in[2], 1'b1,1'b1};
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
                lru_out = {lru_in[2], 1'b0,1'b1};
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
                lru_out = {1'b1, lru_in[1],1'b0};
                ctl.load_lru = 1;
                mem_resp = 1;
                pmemwdata_sel = 1;
            end
            if(way_state.way3.hit & (mem_read ^ mem_write)) begin
                if(mem_write) begin
                    ctl.way3.d_in = 1;
                    ctl.way3.load_d = 1;
                    ctl.way3.load_TD = 1;
                end
                lru_out = {1'b0, lru_in[1],1'b0};
                ctl.load_lru = 1;
                mem_resp = 1;
                pmemwdata_sel = 1;
            end
        end
        fetch_cline: begin
            pmem_read = 1;
            case(lru_sel)
                2'b00:
                    begin
                        ctl.way0.v_in = 1;
                        ctl.way0.d_in = 0;
                        ctl.way0.load_v = 1;
                        ctl.way0.load_d = 1;
                        ctl.way0.load_TD = 1;
                    end
                2'b01:
                    begin
                        ctl.way1.v_in = 1;
                        ctl.way1.d_in = 0;
                        ctl.way1.load_v = 1;
                        ctl.way1.load_d = 1;
                        ctl.way1.load_TD = 1;
                    end
                2'b10:
                    begin
                        ctl.way2.v_in = 1;
                        ctl.way2.d_in = 0;
                        ctl.way2.load_v = 1;
                        ctl.way2.load_d = 1;
                        ctl.way2.load_TD = 1;
                    end
                2'b11:
                    begin
                        ctl.way3.v_in = 1;
                        ctl.way3.d_in = 0;
                        ctl.way3.load_v = 1;
                        ctl.way3.load_d = 1;
                        ctl.way3.load_TD = 1;
                    end
            endcase
        end
        write_back: begin
            pmem_write = 1;
            pmemwdata_sel = lru_sel;
            pmemaddr_sel = {1'b0, lru_sel}+3'b001;
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
                else
                    next_state = fetch_cline;
            end else if(mem_read ^ mem_write) begin
                next_state = buffer;
<<<<<<< HEAD
            end
=======
				end
>>>>>>> master
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
<<<<<<< HEAD
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
=======
    pmem_address <= pmem_address_inter;
end

always_comb begin
    case ({lru_in[0], lru_in[1], lru_in[2]})
        3'b000: lru_sel = 2'b00;
        3'b001: lru_sel = 2'b00;
        3'b010: lru_sel = 2'b01;
        3'b011: lru_sel = 2'b01;
        3'b100: lru_sel = 2'b10;
        3'b101: lru_sel = 2'b11;
        3'b110: lru_sel = 2'b10;
        3'b111: lru_sel = 2'b11;
        default:;
>>>>>>> master
    endcase
end

endmodule : l2_cache_control
