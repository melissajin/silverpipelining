import lc3b_types::*;

module hardware_prefetcher_controller
(
    input clk,

    /***** Control Signals *****/
    input lc3b_word prefetch_addr,
    input valid, pf_prediction, new_line,
    output logic load_pf_line, load_pf_addr, i_rdata_sel, l2_address_sel,
    output logic [1:0] pf_hit,

    /***** I-Cache Signals *****/
    input i_read,
    input lc3b_word i_address,
    output logic i_resp,

    /***** L2 Arbiter Signals *****/
    input l2_resp,
    output logic l2_read
);

enum int unsigned {
    process_request, fetch_cline, prefetch_cline
} state, next_state;

always_comb
begin : state_actions
    load_pf_addr = 1'b0; load_pf_line = 1'b0; i_rdata_sel = 1'b0;
    i_resp = 1'b0; l2_read = 1'b0; l2_address_sel = 1'b0; pf_hit = 2'b00;

    case(state)
        process_request: begin
            if((prefetch_addr == i_address) & valid & i_read) begin
                pf_hit = 2'b11;
                if(new_line) begin
                    i_rdata_sel = 1'b1;
                    i_resp = 1'b1;
                end
               // load_pf_addr = 1'b1;     ---> check performance difference
           end
           else if((prefetch_addr != i_address) & new_line & i_read) begin
               pf_hit = 2'b10;
           end
        end
        fetch_cline: begin
            load_pf_addr = 1'b1;
            l2_read = 1'b1;
            i_rdata_sel = 1'b0;
            l2_address_sel = 1'b0;
            if(l2_resp == 1'b1)
                i_resp = 1'b1;
        end
        prefetch_cline: begin
            l2_read = 1'b1;
            load_pf_line = 1'b1;
            l2_address_sel = 1'b1;
        end
        default: ; // Nothing
    endcase
end

always_comb
begin : next_state_logic
	next_state = state;

	case(state)
		process_request: begin
            if((prefetch_addr != i_address || (~valid) || (~new_line)) && i_read) begin
                next_state = fetch_cline;
            end
		end
		fetch_cline: begin
        if(l2_resp == 1'b1 && pf_prediction == 1'b1)
            next_state = prefetch_cline;
        else if(l2_resp == 1'b1)
            next_state = process_request;
		end
		prefetch_cline: begin
            if(l2_resp == 1'b1) begin
                if(prefetch_addr == i_address || i_read == 1'b0)
                    next_state = process_request;
                else
                    next_state = fetch_cline;
            end
		end
		default: ; // Nothing
	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
	state <= next_state;
end

endmodule : hardware_prefetcher_controller
