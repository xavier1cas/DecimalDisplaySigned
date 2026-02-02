`timescale 1ps/1ps

module SignDetector #(parameter N=16) (
    input  wire [N-1:0] s_in_binary,
    output wire   [3:0] sign,
    output wire [N-1:0] ns_in_binary
);
    assign sign = s_in_binary[N-1] ? 4'hf : 4'he; // 4'hf for negative (negative sign), 4'he for positive (blank display)
    assign ns_in_binary = s_in_binary[N-1] ? (~s_in_binary + 1) : s_in_binary;

endmodule