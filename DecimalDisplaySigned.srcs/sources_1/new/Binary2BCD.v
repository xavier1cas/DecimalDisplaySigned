`timescale 1ps/1ps

module Binary2BCD #(parameter N=16, D=4) (
    input  wire [N-1:0]   in_binary,
    output wire [4*D-1:0] packed_bcd
);    

    wire [N+4*D-1:0] scratch_pad;
    wire [N+4*D-1:0] packed_bcd_step [2:N];

    assign scratch_pad = {{(N+4*D){1'b0}}, in_binary};
    assign packed_bcd_step[2] = scratch_pad << 2;
    assign packed_bcd_step[N] = packed_bcd_step[N-1] << 1;
    assign packed_bcd = packed_bcd_step[N][N+4*D-1:N];
    
    genvar i;
    generate
        for (i=3; i<N; i=i+1) begin : DabbleStep
            DoubbleDabble #(N, D) DB (
                .scratch_pad(packed_bcd_step[i-1]),
                .packed_bcd(packed_bcd_step[i])
            );
        end
    endgenerate


endmodule
