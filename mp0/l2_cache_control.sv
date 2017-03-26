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
    output lc3b_cacheline pmem_wdata
);

/* List of states */
enum int unsigned {
    process_request, fetch_cline, write_back
} state, next_state;

logic [2:0] lru_sel;
logic [1:0] leafNode;
logic hit, dirty_lru;
assign hit = way_state.way0.hit | way_state.way1.hit | way_state.way2.hit | way_state.way3.hit
            | way_state.way4.hit | way_state.way5.hit | way_state.way6.hit | way_state.way7.hit;
assign dirty_lru = (way_state.way0.d_out == 1 && lru_sel == 0) || (way_state.way1.d_out == 1 && lru_sel == 1) ||
                   (way_state.way2.d_out == 1 && lru_sel == 2) || (way_state.way3.d_out == 1 && lru_sel == 3) ||
                   (way_state.way4.d_out == 1 && lru_sel == 4) || (way_state.way5.d_out == 1 && lru_sel == 5) ||
                   (way_state.way6.d_out == 1 && lru_sel == 6) || (way_state.way7.d_out == 1 && lru_sel == 7);
always_comb
begin : state_actions
    /* Default output assignments */
    ctl = 0;
    pmemwdata_sel = 0;
    pmemaddr_sel = 4'h0;
    mem_resp = 0; pmem_read = 0; pmem_write = 0;
	 lru_out = lru_in;

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
                pmemwdata_sel = 1;
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
                pmemwdata_sel = 1;
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
                pmemwdata_sel = 1;
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
                pmemwdata_sel = 1;
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
                pmemwdata_sel = 1;
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
                pmemwdata_sel = 1;
            end
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
            pmem_write = 1;
            pmemwdata_sel = lru_sel;
            pmemaddr_sel = {1'b0, lru_sel}+4'b0001;
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
            end
        end
        fetch_cline: begin
            if(pmem_resp == 1)
                next_state = process_request;
        end
        write_back: begin
            if(pmem_resp == 1)
                next_state = fetch_cline;
        end
        default: next_state = process_request;
    endcase


end

always_comb begin
    case({lru_in[0], lru_in[1], lru_in[2]})
        3'b000: leafNode = 0;
        3'b001: leafNode = 0;
        3'b010: leafNode = 1;
        3'b011: leafNode = 1;
        3'b100: leafNode = 2;
        3'b101: leafNode = 3;
        3'b110: leafNode = 2;
        3'b111: leafNode = 3;
        default : ;
    endcase

    lru_sel = {leafNode, lru_in[leafNode+3]};
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
    state <= next_state;
    pmem_wdata <= pmem_wdata_inter;
    pmem_address <= pmem_address_inter;
end

endmodule : l2_cache_control
