import lc3b_types::*;

// Parameter can be 3, 4, 5, or 6. Anything else = static not taken branch prediction
module branch_predictor #(parameter num_addr_bits = 4)
(
    input clk,

    // inputs to driuve the predictor's state
    input lc3b_word mem_address,
    input br_instruction,
    input taken,
    input not_taken,

    // Predictor's current foretelling
    output logic prediction, prediction_sync,
    output logic branch_in_flight_out
);

logic[(1<<num_addr_bits)-1:0] decode_output;
logic[(1<<num_addr_bits)-1:0] prediction_output;
lc3b_word mem_addr_reg_out;

logic branch_in_flight, branch_in_flight_next;

decoder_N #(.N(num_addr_bits)) counter_chooser
(
    .a(mem_addr_reg_out[num_addr_bits:1]),
    .y(decode_output)
);

register mem_addr_reg
(
    .clk,
    .load(br_instruction & ~branch_in_flight),
    .in(mem_address),
    .out(mem_addr_reg_out)
);

initial begin
    branch_in_flight = 1'b0;
end

/* Use a generate loop to initialize the "predictor table" */
generate
    genvar i;
    for(i = 0; i < (1 << num_addr_bits); i++)
        begin : module_instant_loop
            saturating_counter sat_counter_inst
            (
                .clk,

                // Saturating counter inputs
                .taken(taken & decode_output[i]),
                .not_taken(not_taken & decode_output[i]),

                // Saturating counter outputs
                .prediction(prediction_output[i])
            );
        end

endgenerate

assign prediction_sync = prediction_output[mem_addr_reg_out[num_addr_bits:1]];
assign prediction = prediction_output[mem_address[num_addr_bits:1]];
assign branch_in_flight_out = branch_in_flight;

// always @ (posedge br_instruction or posedge taken or posedge not_taken) begin
always_ff @ (posedge clk) begin
    branch_in_flight <= branch_in_flight_next;
end

always_comb begin
    branch_in_flight_next = branch_in_flight;
    if(taken | not_taken) // Branch has ended
        branch_in_flight_next = 1'b0;
    else if(br_instruction & ~branch_in_flight)
        branch_in_flight_next = 1'b1;
end

endmodule : branch_predictor
