import lc3b_types::*;

module physical_memory
(
    input clk,
    input read,
    input write,
    input lc3b_word address,
    input lc3b_cacheline wdata,
    output logic resp,
    output lc3b_cacheline rdata
);

timeunit 1ns;
timeprecision 1ns;

parameter DELAY_MEM = 250;

lc3b_cacheline mem [0:2**($bits(address)- 5)-1];
logic [10:0] internal_address;
logic ready;

/* Initialize memory contents from memory.lst file */
initial
begin
    $readmemh("memory.lst", mem);
end

assign internal_address = address[15:5];

enum int unsigned {
    idle,
    busy,
    respond
} state, next_state;

always @(posedge clk)
begin
    /* Default */
    resp = 1'b0;

    next_state = state;

    case(state)
        idle: begin
            if (read | write) begin
                next_state = busy;
                ready <= #DELAY_MEM 1;
            end
        end

        busy: begin
            if (ready == 1) begin
                if (write) begin
                    mem[internal_address] = wdata;
                end

                rdata = mem[internal_address];
                resp = 1;

                next_state = respond;
            end
        end

        respond: begin
            ready <= 0;
            next_state = idle;
        end

        default: next_state = idle;
    endcase
end

always_ff @(posedge clk)
begin : next_state_assignment
    state <= next_state;
end

endmodule : physical_memory
