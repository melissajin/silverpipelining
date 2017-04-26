import lc3b_types::*;

module saturating_counter
(
    input clk,

    // inputs to driuve the counter's state
    input logic br_instruction,
    input logic taken,
    input logic not_taken,

    // Counter's current prediction
    output logic prediction // 1 for taken, 0 for not taken
);

/* List of states */
enum int unsigned {
  weakly_not_taken, weakly_taken, strongly_taken, strongly_not_taken
} state, next_state;

initial begin
    state = weakly_not_taken;
end

always_comb
begin : state_actions
	 case(state)
      weakly_not_taken:
          prediction = 1'b0;
      weakly_taken:
          prediction = 1'b1;
      strongly_not_taken:
          prediction = 1'b0;
      strongly_taken:
          prediction = 1'b1;
      default: ; // Will never happen
   endcase
end

always_comb
begin : next_state_logic
	next_state = state;

	case(state)
      weakly_not_taken: begin
          if(br_instruction & br_taken) // taken branch
              next_state = weakly_taken;
          else if(br_instruction) // not taken branch
              next_state = strongly_not_taken;
      end

      weakly_taken: begin
          if(br_instruction & br_taken) // taken branch
              next_state = strongly_taken;
          else if(br_instruction) // not taken branch
              next_state = weakly_not_taken;
      end

      strongly_not_taken: begin
          if(br_instruction & br_taken) // taken branch
              next_state = weakly_not_taken;
          else if(br_instruction) // not taken branch
              next_state = strongly_not_taken;
      end

      strongly_taken: begin
          if(br_instruction & br_taken) // taken branch
              next_state = strongly_taken;
          else if(br_instruction) // not taken branch
              next_state = weakly_taken;
      end

      default: ; // Will never happen
	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
	state <= next_state;
end

endmodule : saturating_counter
