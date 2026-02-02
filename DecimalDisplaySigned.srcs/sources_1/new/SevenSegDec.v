`timescale 1ps/1ps

module SevenSegDec (
    input      [3:0] BCD,
    output reg [6:0] seg_out
);

    always @(*) begin
        case (BCD)
                                // gfe_dcba
            4'h0    : seg_out = 7'b100_0000;
            4'h1    : seg_out = 7'b111_1001;
            4'h2    : seg_out = 7'b010_0100;
            4'h3    : seg_out = 7'b011_0000;
            4'h4    : seg_out = 7'b001_1001;
            4'h5    : seg_out = 7'b001_0010;
            4'h6    : seg_out = 7'b000_0010;
            4'h7    : seg_out = 7'b111_1000;
            4'h8    : seg_out = 7'b000_0000;
            4'h9    : seg_out = 7'b001_0000;
            4'he    : seg_out = 7'b111_1111; // Blank Display
            4'hf    : seg_out = 7'b011_1111; // Negative Sign
            default : seg_out = 7'bxxx_xxxx;
        endcase
    end

endmodule