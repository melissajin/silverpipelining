
module l2_cache_control
(
    input clk,

    /* Control signals */
    input logic [6:0] lru_out,
    input lc3b_L2_state state,
    output lc3b_L2_ctl ctl,
    output [6:0] lru_in,
    output [2:0] pmemwdata_sel,
    output [3:0] pmemaddr_sel,

    /* CPU signals */
    input mem_read, mem_write,
    output logic mem_resp,

    /* Memory signals */
    input pmem_resp,
    output logic pmem_read, pmem_write
);

/* List of states */
enum int unsigned {
    process_request, fetch_cline, write_back
} state, next_state;

always_comb
begin : state_actions
    /* Default output assignments */
    ctl = 0;
    pmemwdata_sel = 2'b00;
    pmemaddr_sel = 3'b000;
    mem_resp = 0; pmem_read = 0; pmem_write = 0;


    case (state)
        process_request: begin
            if(state.way0.hit & (mem_read ^ mem_write)) begin
                if(mem_write) begin
                    d_in0 = 1;
                    load_d0 = 1;
	                load_TD0 = 1;
                end
                lru_in = 1;
                load_lru = 1;
                mem_resp = 1;
	            pmemwdata_sel = 0;
            end
            if(state.way0.hit & (mem_read ^ mem_write)) begin
                if(mem_write) begin
                    d_in1 = 1;
                    load_d1 = 1;
	                load_TD1 = 1;
                end
                lru_in = 0;
                load_lru = 1;
                mem_resp = 1;
 	             pmemwdata_sel = 1;
            end
        end
        fetch_cline: begin
            pmem_read = 1;
            if(lru_out == 0) begin
                v_in0 = 1;
                d_in0 = 0;
                load_v0 = 1;
                load_d0 = 1;
                load_TD0 = 1;
            end else begin
                v_in1 = 1;
                d_in1 = 0;
                load_v1 = 1;
                load_d1 = 1;
                load_TD1 = 1;
            end
        end
        write_back: begin
            pmem_write = 1;
            pmemwdata_sel = lru_out;
            if(lru_out == 0)
                pmemaddr_sel = 2'b01;
            else
                pmemaddr_sel = 2'b10;
        end
        default:;
    endcase


end

always_comb
begin : next_state_logic
    next_state = state;

    case (state)
        process_request: begin
            if(~(state.way0.hit | state.way1.hit) & (mem_read ^ mem_write)) begin
                if((d_out0 == 1 && lru_out == 0) || (d_out1 == 1 && lru_out == 1))
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

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
    state <= next_state;
end


endmodule : l2_cache_control
