module physical_memory_dp
(
    input clk,

    input read_i,
    input write_i,
    input [15:0] address_i,
    input [127:0] wdata_i,
    output logic resp_i,
    output logic [127:0] rdata_i,

    input read_d,
    input write_d,
    input [15:0] address_d,
    input [127:0] wdata_d,
    output logic resp_d,
    output logic [127:0] rdata_d
);

timeunit 1ns;
timeprecision 1ns;

parameter DELAY_MEM = 200;

logic [127:0] mem [0:2**($bits(address_i)-4)-1];
logic [11:0] internal_address_i;
logic [11:0] internal_address_d;
logic ready_i, ready_d;

/* Initialize memory contents from memory.lst file */
initial
begin
    $readmemh("memory.lst", mem);
end

assign internal_address_i = address_i[15:4];
assign internal_address_d = address_d[15:4];

enum int unsigned {
    idle,
    busy,
    respond
} state_i, next_state_i, state_d, next_state_d;

always @(posedge clk)
begin
    /* Default */
    resp_i = 1'b0;
    resp_d = 1'b0;

    next_state_i = state_i;
    next_state_d = state_d;

    case(state_i)
        idle: begin
            if (read_i | write_i) begin
                next_state_i = busy;
                ready_i <= #DELAY_MEM 1;
            end
        end

        busy: begin
            if (ready_i == 1) begin
                if (write_i) begin
                    mem[internal_address_i] = wdata_i;
                end

                rdata_i = mem[internal_address_i];
                resp_i = 1;

                next_state_i = respond;
            end
        end

        respond: begin
            ready_i <= 0;
            next_state_i = idle;
        end

        default: next_state_i = idle;
    endcase

    case(state_d)
        idle: begin
            if (read_d | write_d) begin
                next_state_d = busy;
                ready_d <= #DELAY_MEM 1;
            end
        end

        busy: begin
            if (ready_d == 1) begin
                if (write_d) begin
                    mem[internal_address_d] = wdata_d;
                end

                rdata_d = mem[internal_address_d];
                resp_d = 1;

                next_state_d = respond;
            end
        end

        respond: begin
            ready_d <= 0;
            next_state_d = idle;
        end

        default: next_state_d = idle;
    endcase
end

always_ff @(posedge clk)
begin : next_state_assignment
    state_i <= next_state_i;
    state_d <= next_state_d;
end

endmodule : physical_memory_dp
