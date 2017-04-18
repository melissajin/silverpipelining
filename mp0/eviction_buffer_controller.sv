import lc3b_types::*;

module eviction_buffer_controller
(
    input clk,

    // control signals
    input lc3b_7b_plru lru_in,
    input lc3b_eviction_array_entry data_array [7:0],
    input hits [7:0],
    output logic load,
    output lc3b_7b_plru lru_out,
    output logic valid,
    output logic dirty,
    output logic [3:0] index,
    output logic read_src_sel,

    input buf_mem_read, buf_mem_write,
    input lc3b_word buf_mem_address,
    output logic buf_mem_resp,
    /******* Signals between L2 Cache and Physical Memory *******/
    input super_mem_resp,
    output logic super_mem_read, super_mem_write,
);

/* List of states */
enum int unsigned {
    process_request, fetch_cline, write_back
} state, next_state;

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

endmodule : eviction_buffer_controller
