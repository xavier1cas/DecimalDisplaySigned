`timescale 1ns / 1ps

module top_tb();

    localparam N=16, D=6, COUNT_DISPLAY = 10, T=50;

    reg          clk=0, reset_n=1;
    reg  [N-1:0] in_binary=0;
    wire [N-1:0] LED;
    wire [7:0]   AN;
    wire [3:0]   seg_display;
    wire [6:0]   seg_out;

    wire [4*D-1:0] packed_bcd;
    
    top_module #(.N(N), .D(D), .COUNT_DISPLAY(COUNT_DISPLAY)) dut (
        .clk(clk),
        .reset_n(reset_n),
        .in_binary(in_binary),
        .LED(LED),
        .AN(AN),
        .seg_out(seg_out)
    );  

    always begin
        clk = ~clk; #(T/2);
    end

    initial begin
        in_binary = 16'h00ad; #(2*D*COUNT_DISPLAY*T); // 173
        in_binary = 16'h00a8; #(2*D*COUNT_DISPLAY*T); // 168
        in_binary = 16'h002b; #(2*D*COUNT_DISPLAY*T); // 43
        in_binary = 16'h00dc; #(2*D*COUNT_DISPLAY*T); // 220
        
        in_binary = 16'h8000; #(2*D*COUNT_DISPLAY*T); // -32768 ** ?
        in_binary = 16'hc000; #(2*D*COUNT_DISPLAY*T); // -16384
        in_binary = 16'he000; #(2*D*COUNT_DISPLAY*T); // -8192
        in_binary = 16'hf000; #(2*D*COUNT_DISPLAY*T); // -4096

        in_binary = 16'hfff8; #(2*D*COUNT_DISPLAY*T); // -8
        in_binary = 16'hfffc; #(2*D*COUNT_DISPLAY*T); // -4
        in_binary = 16'hfffe; #(2*D*COUNT_DISPLAY*T); // -2
        in_binary = 16'hffff; #(2*D*COUNT_DISPLAY*T); // -1

        #(500*T)

        reset_n = 0; #(50*T); reset_n = 1; #(50*T);
        
        $stop;
    end

endmodule
