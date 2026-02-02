`timescale 1ps/1ps
`include "Utilities.vh"

module PulseGenerator #(parameter COUNT = 333333)
(
    input  wire clk,
    input  wire reset_n,
    output wire pulse
);

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
    localparam COUNTER_WIDTH = clog2(COUNT + 1);
    reg [COUNTER_WIDTH-1:0] counter;

    // State Machine
    always @(posedge clk, negedge reset_n) begin
        if (reset_n == 0) counter <= 0;
        else begin
            if (counter < COUNT-1) counter <= counter + 1;
            else counter <= 0;
        end
    end

    // Output Machine
    assign pulse = (counter == COUNT-1) ? 1'b1 : 1'b0;

endmodule