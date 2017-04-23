/*
 * arbiter_control.sv, by the Silver Pipelining team.
 * This is the module containing the state-machine based control unit for our cache arbiter.
 * Its three states are as follows:
 * - Idle: Neither L1 cache is requesting memory access.
 * - D_cache: A request from the Data cache is being serviced.
 * - I_cache: A request from the Instruction cache is being serviced.
 */

 module arbiter_control
 (
	input clk,

	// Inputs driving control decisions
	input priority2_read_in, priority1_read_in,
	input priority2_write_in, priority1_write_in,
	input s_resp_in,

	// Output to datapath
	output logic cache_arbiter_sel, access
 );

 /* List of states */
 enum int unsigned {
	 idle, d_cache, i_cache
 } state, next_state;


always_comb
begin : state_actions
	cache_arbiter_sel = 1'b0;
    if(state == d_cache)
        cache_arbiter_sel = 1'b1;

    // Getting rid of buffering of resp signal issue
    access = 1'b1;
    if(s_resp_in)
        access = 1'b0;
end

always_comb
begin : next_state_logic
	next_state = state;

	case(state)
		idle: begin
    		if(priority1_read_in | priority1_write_in)
				next_state = d_cache;
    		else if(priority2_read_in | priority2_write_in)
				next_state = i_cache;
		end
		d_cache: begin
			if(s_resp_in)
					next_state = idle;
			else begin
                if(priority1_read_in | priority1_write_in)
                    next_state = d_cache;
                else
                    next_state = idle;
			end
		end
		i_cache: begin
			if(s_resp_in)
                next_state = idle;
			else begin
                if(priority2_read_in | priority2_write_in)
                    next_state = i_cache;
                else
                    next_state = idle;
			end
		end
		default: begin ; end // Nothing
	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
	state <= next_state;
end

 endmodule : arbiter_control
