`timescale 1ps/1ps

module top_module #(parameter N=16, D=6, COUNT_DISPLAY=333333) (
    input  wire         clk,
    input  wire         reset_n,
    input  wire [N-1:0] in_binary,
    output wire [N-1:0] LED,
    output wire   [7:0] AN,
    output wire   [6:0] seg_out
);
    wire [4*(D-1)-1:0] packed_bcd;
    wire         [3:0] sign;
    wire       [N-1:0] ns_in_binary;
    wire         [3:0] BCD;
    wire       [D-1:0] AN_tmp;
    wire               pulse_display_enable;
    
    SignDetector #(.N(N)) SIGN_DETECT(
        .s_in_binary    (in_binary),
        .sign           (sign),
        .ns_in_binary   (ns_in_binary)
    );

    Binary2BCD #(.N(N), .D(D-1)) B2BCD ( 
        // N   with ns_in_binary[N-1:0] captures [-2^(N-1)  , 2^(N-1)-1]
        // N-1 with ns_in_binary[N-2:0] captures [-2^(N-1)-1, 2^(N-1)-1]
        // leaving the lowest negative number, and getting 0 and -0 on display
        // but saves area in the FPGA
        .in_binary  (ns_in_binary),
        .packed_bcd (packed_bcd)
    );

    PulseGenerator #(.COUNT(COUNT_DISPLAY)) FREQ_GENERATOR (
        .clk        (clk),
        .reset_n    (reset_n),
        .pulse      (pulse_display_enable)
    );
    
    DisplayController #(.N(N), .D(D)) DISP_CONTROLLER(
        .clk            (clk),
        .reset_n        (reset_n),
        .display_enable (pulse_display_enable),
        .packed_bcd     ({sign, packed_bcd}),
        .AN             (AN_tmp),
        .out_segment    (BCD)
    );

    SevenSegDec DECO_7_SEG (
        .BCD        (BCD),
        .seg_out    (seg_out)
    );

    assign AN = {{(8-D){1'b1}}, AN_tmp};
    assign LED = in_binary;

endmodule