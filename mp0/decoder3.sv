module decoder3
(
    input [2:0] encodedvalue,
    output logic [7:0] decodedvalue
);


always_comb
begin
    case(encodedvalue)
        3'b000:     decodedvalue = 8'b00000001;
        3'b001:     decodedvalue = 8'b00000010;
        3'b010:     decodedvalue = 8'b00000100;
        3'b011:     decodedvalue = 8'b00001000;
        3'b100:     decodedvalue = 8'b00010000;
        3'b101:     decodedvalue = 8'b00100000;
        3'b110:     decodedvalue = 8'b01000000;
        3'b111:     decodedvalue = 8'b10000000;
        default:    decodedvalue = 8'b00000000;
    endcase
end

endmodule : decoder3