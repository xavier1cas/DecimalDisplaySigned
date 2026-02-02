`include "Utilities.vh"

module DoubbleDabble #(parameter N=32, D=3) (
    input      [N+4*D-1:0] scratch_pad,
    output reg [N+4*D-1:0] packed_bcd
);

    wire [N+4*D-1:0] dabble_reg;

    assign dabble_reg = scratch_pad << 1;
    
    integer k;
    always @(*) begin
        packed_bcd = dabble_reg; 
        for(k=0; k<D-1; k=k+1) begin
            if (dabble_reg[N+k*4 +:4] > 4'd4) packed_bcd[N+k*4 +:4] = dabble_reg[N+k*4 +:4] + 4'd3;
            else                              packed_bcd[N+k*4 +:4] = dabble_reg[N+k*4 +:4];
        end
    end

endmodule