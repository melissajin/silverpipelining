// Module used to assist the performance counters implementation

import lc3b_types::*;

module address_decode
(
  input lc3b_word mem_address,
  input lc3b_opcode opcode,
  output logic [3:0] mux_sel,
  output logic clear_counter_0,
  output logic clear_counter_1,
  output logic clear_counter_2,
  output logic clear_counter_3,
  output logic clear_counter_4,
  output logic clear_counter_5,
  output logic clear_counter_6,
  output logic clear_counter_7,
  output logic clear_counter_8
);

always_comb begin
    mux_sel = 4'h0;
    clear_counter_0 = 1'b0;
    clear_counter_1 = 1'b0;
    clear_counter_2 = 1'b0;
    clear_counter_3 = 1'b0;
    clear_counter_4 = 1'b0;
    clear_counter_5 = 1'b0;
    clear_counter_6 = 1'b0;
    clear_counter_7 = 1'b0;
    clear_counter_8 = 1'b0;

    case(mem_address)
      // L2 hits
        16'hfff0: begin
            mux_sel = 4'h1;
            if(opcode == op_str || opcode == op_sti) clear_counter_0 = 1'b1;
        end
      // L2 misses
        16'hffee: begin
            mux_sel = 4'h2;
            if(opcode == op_str || opcode == op_sti) clear_counter_1 = 1'b1;
        end
      // DL1 hits
        16'hffec: begin
            mux_sel = 4'h3;
            if(opcode == op_str || opcode == op_sti) clear_counter_2 = 1'b1;
        end
      // DL1 misses
        16'hffea: begin
            mux_sel = 4'h4;
            if(opcode == op_str || opcode == op_sti) clear_counter_3 = 1'b1;
        end
      // IL1 hits
        16'hffe8: begin
            mux_sel = 4'h5;
            if(opcode == op_str || opcode == op_sti) clear_counter_4 = 1'b1;
        end
      // IL1 misses
        16'hffe6: begin
            mux_sel = 4'h6;
            if(opcode == op_str || opcode == op_sti) clear_counter_5 = 1'b1;
        end
      // Branch predicts
        16'hffe4: begin
            mux_sel = 4'h7;
            if(opcode == op_str || opcode == op_sti) clear_counter_6 = 1'b1;
        end
      // Branch mispredicts
        16'hffe2: begin
            mux_sel = 4'h8;
            if(opcode == op_str || opcode == op_sti) clear_counter_7 = 1'b1;
        end
      // Number of cycles spent in stall
        16'hffe0: begin
            mux_sel = 4'h9;
            if(opcode == op_str || opcode == op_sti) clear_counter_8 = 1'b1;
        end
      default: ;
    endcase
end

endmodule : address_decode
