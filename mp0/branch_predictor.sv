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
    output logic prediction
);

logic[(1<<num_addr_bits):0] decode_output;
logic[(1<<num_addr_bits):0] prediction_output;

decoder_N #(.N(num_addr_bits)) counter_chooser
(
    .a(mem_address[num_addr_bits:1]),
    .y(decode_output)
);

/* Use a generate loop to initialize the "predictor table" */
generate
    genvar i;
    for(i = 0; i < (1 << num_addr_bits); i++)
        begin : module_instant_loop
            saturating_counter sat_counter_inst
            (
                .clk,

                // Saturating counter inputs
                .br_instruction(br_instruction & decode_output[i]),
                .taken,
                .not_taken,

                // Saturating counter outputs
                .prediction(prediction_output[i])
            );
        end

endgenerate

assign prediction = prediction_output[mem_address[num_addr_bits:1]];

endmodule : branch_predictor
