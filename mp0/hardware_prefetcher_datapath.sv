import lc3b_types::*;

module hardware_prefetcher_datapath
(
    input clk,

    /***** Control Signals *****/


    /***** PMem Arbiter Signals *****/


    /***** L2 Arbiter Signals *****/


);

register #($bits(lc3b_control_word_mem)) prefetch_cline
(
    .clk,
    .load(),
    .in(prefetch_cline_in),
    .out(prefetch_cline_out)
);


endmodule : hardware_prefetcher_datapath
