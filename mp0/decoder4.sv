module decoder4
(
    input [3:0] encodedvalue,
    output logic [15:0] decodedvalue
);


always_comb
begin
    case(encodedvalue)
        4'b0000:     decodedvalue = 16'b0000000000000001;
        4'b0001:     decodedvalue = 16'b0000000000000010;
        4'b0010:     decodedvalue = 16'b0000000000000100;
        4'b0011:     decodedvalue = 16'b0000000000001000;
        4'b0100:     decodedvalue = 16'b0000000000010000;
        4'b0101:     decodedvalue = 16'b0000000000100000;
        4'b0110:     decodedvalue = 16'b0000000001000000;
        4'b0111:     decodedvalue = 16'b0000000010000000;
        4'b1000:     decodedvalue = 16'b0000000100000000;
        4'b1001:     decodedvalue = 16'b0000001000000000;
        4'b1010:     decodedvalue = 16'b0000010000000000;
        4'b1011:     decodedvalue = 16'b0000100000000000;
        4'b1100:     decodedvalue = 16'b0001000000000000;
        4'b1101:     decodedvalue = 16'b0010000000000000;
        4'b1110:     decodedvalue = 16'b0100000000000000;
        4'b1111:     decodedvalue = 16'b1000000000000000;
        default:     decodedvalue = 16'b0000000000000000;
    endcase
end

endmodule : decoder4
