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

 enum int unsigned {
    /* List of states */
	 idle,
	 d_cache,
	 i_cache,
     buffer
 } state, next_state;


 always_comb
	begin : state_actions
		/* Default output assignments */
		cache_arbiter_sel = 1'b0;

		/* Actions for each state */
		case(state)

			idle:
				begin
					cache_arbiter_sel = 1'b0;
				end

			d_cache:
				begin
					cache_arbiter_sel = 1'b1;
				end

			i_cache:
				begin
					cache_arbiter_sel = 1'b0;
				end

            buffer:
				begin
					cache_arbiter_sel = 1'b0;
				end

			default: begin ; end // Nothing

		endcase
	end

always_comb
	begin : next_state_logic

		next_state = state; // The default next state

		/* Next state information and conditions (if any) for transitioning between states */
		case(state)

			idle:
				begin
					if(d_cache_read_in | d_cache_write_in) // D-Cache request
						begin
							next_state = d_cache;
						end

					else if(i_cache_read_in | i_cache_write_in) // I-Cache request
						begin
							next_state = i_cache;
						end

					else // No memory request
						begin
							next_state = idle;
						end
				end

			d_cache:
				begin
					if(l2_resp_in) // If the L2 has responded to D-cache's request
						begin
    						next_state = buffer;
						end

					else
						begin
                            if(d_cache_read_in | d_cache_write_in)
                                next_state = d_cache; // Must remain in the same state if L2 hasn't responded
                            else
                                next_state = idle;
						end
				end

			i_cache:
				begin
					if(l2_resp_in) // If the L2 has responded to I-cache's request
						begin
                            next_state = buffer;
						end

					else
						begin
                            if(i_cache_read_in | i_cache_write_in)
                                next_state = i_cache; // Must remain in the same state if L2 hasn't responded
                            else
                                next_state = idle;
						end
				end

            buffer:
                begin
                    if(d_cache_read_in | d_cache_write_in)
                        begin
                            next_state = d_cache; // Transition to the d-cache state if D-cache now has a request
                        end

                    else if(i_cache_read_in | i_cache_write_in) // Another I-Cache request
                        begin
                            next_state = i_cache; // Stay in the same state
                        end

                    else // No memory request
                        begin
                            next_state = idle;
                        end
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
