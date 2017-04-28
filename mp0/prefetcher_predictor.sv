module prefetcher_predictor
(
    input clk,
    input [1:0] hit,
    output logic prediction
);

enum int unsigned {
    weakly_taken, strongly_taken, weakly_not_taken, strongly_not_taken
} state, next_state;

always_comb
begin : state_actions
    prediction = 1'b0;
    case(state)
        strongly_taken, weakly_taken: begin
            prediction = 1'b1;
        end
        weakly_not_taken, strongly_not_taken: begin
            prediction = 1'b0;
        end
        default: ; // Nothing
    endcase
end

always_comb
    begin : next_state_logic
      	next_state = state;
      	case(state)
        strongly_taken: begin
            if(hit == 2'b11)
                next_state = strongly_taken;
            else if(hit == 2'b10)
                next_state = weakly_taken;
        end
        weakly_taken: begin
            if(hit == 2'b11)
                next_state = strongly_taken;
            else if(hit == 2'b10)
                next_state = weakly_not_taken;
        end
        weakly_not_taken: begin
            if(hit == 2'b11)
                next_state = weakly_taken;
            else if(hit == 2'b10)
                next_state = strongly_not_taken;
        end
        strongly_not_taken: begin
            if(hit == 2'b11)
                next_state = weakly_not_taken;
            else if(hit == 2'b10)
                next_state = strongly_not_taken;
            end
    		default: ; // Nothing
  	endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
	state <= next_state;
end

endmodule : prefetcher_predictor
