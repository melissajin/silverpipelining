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
	input i_cache_read_in, d_cache_read_in,
	input i_cache_write_in, d_cache_write_in, // i_cache_write_in will always be 0
	input l2_resp_in,

	// Output to datapath
	output logic cache_arbiter_sel
 );

 /* List of states */
 enum int unsigned {
	 idle, d_cache, i_cache, buffer
 } state, next_state;


always_comb
begin : state_actions
	/* Default output assignments */
	cache_arbiter_sel = 1'b0;

	/* Actions for each state */
    if(state == d_cache)
        cache_arbiter_sel = 1'b1;
end

always_comb
begin : next_state_logic
	next_state = state;

	/* Next state information and conditions (if any) for transitioning between states */
	case(state)
		idle: begin
    		if(d_cache_read_in | d_cache_write_in)
				next_state = d_cache;
    		else if(i_cache_read_in | i_cache_write_in)
				next_state = i_cache;
    		else
				next_state = idle;
		end
		d_cache: begin
			if(l2_resp_in)
					next_state = buffer;
			else begin
                if(d_cache_read_in | d_cache_write_in)
                    next_state = d_cache;
                else
                    next_state = idle;
			end
		end
		i_cache: begin
			if(l2_resp_in)
                next_state = buffer;
			else begin
                if(i_cache_read_in | i_cache_write_in)
                    next_state = i_cache;
                else
                    next_state = idle;
			end
		end
        buffer: begin
            if(d_cache_read_in | d_cache_write_in)
                next_state = d_cache;
            else if(i_cache_read_in | i_cache_write_in)
                next_state = i_cache;
            else
                next_state = idle;
        end
		default: begin ; end // Nothing
	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
	/* Assignment of next state on clock edge */
	state <= next_state;
end

 endmodule : arbiter_control
