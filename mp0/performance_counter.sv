/*
 * Performance counter to track pipeline stalls (in number of cycles), cache hits/misses
 * (separate counters will be instantiated for hits and misses), and branch prediction
 * (counts number of correct and number of incorrect predictions).
 *
 * Implementation: Essentially a glorified register, driven by cache controller, hazard detection unit, etc.
 * Note: it can only count up to 2^16 things (may increase if necessary)
 */

module performance_counter #(parameter width = 16)
(
    input clk,
    input increment,
    input clear,
    output logic [width-1:0] output_count
);

logic[width-1:0] count, next_count;

/* Initialize count to 0 */
initial
  begin
    for (int i = 0; i < $size(count); i++)
      begin
          count[i] = 1'b0;
      end
  end

/* Update on rising clock edge */
always_ff @(posedge clk)
  begin
      count = next_count;
  end

/* Combinational logic for output and next_count */
always_comb
  begin
    if(clear == 1)
      begin
        next_count = 0;
      end
    else if(increment == 1)
      begin
        next_count = count + 16'h1;
      end
    else
      begin
        next_count = count;
      end

    output_count = count;

  end

endmodule : performance_counter
