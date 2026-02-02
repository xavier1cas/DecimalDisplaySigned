`timescale 1ps/1ps
`include "Utilities.vh"

module DisplayController #(parameter N=8, D=4) (
    input  wire           clk,
    input  wire           reset_n,
    input  wire           display_enable,
    input  wire [4*D-1:0] packed_bcd,
    output reg  [D-1:0]   AN,
    output reg  [3:0]     out_segment
);

    // Displays time multiplexing =======================================================
    // Utility function to compute log2 ceiling
    function integer clog2;
        input integer value;
        integer i;
        begin
            clog2 = 0;
            for (i = value - 1; i > 0; i = i >> 1)
                // Start with i = value - 1 (e.g. if value is 456, i = 455)
                // While i > 0, divide it by 2 (i = i >> 1 shifts right by 1 bit).
                // Every time we divide i, we increment clog2 by 1.
                clog2 = clog2 + 1;
        end
    endfunction
    localparam COUNTER_WIDTH = clog2(D + 1);
    reg [COUNTER_WIDTH-1:0] display_counter;
 
    // State Machine
    always @(posedge clk, negedge reset_n) begin
        if (reset_n == 0) display_counter <= 0;
        else if (display_enable) begin
            if (display_counter < D) display_counter <= display_counter + 1;
            else                     display_counter <= 1;
        end
    end

    // Output Machine
    always @(*) begin
        /* Generate the output for the anodes of the Displays */
        AN = {D{1'b1}};
        if (display_counter != 0) AN[display_counter-1] = 0;

        /* Generate the output for the segments */
        out_segment = packed_bcd[(display_counter-1)<<2 +:4];
    end
    // ====================================================================================

endmodule
