`timescale 1ns / 1ps

module tb_lfsr();
    reg clk, reset;
    wire [7:0] random_num;

    lfsr uut(.clk(clk), .reset(reset), .random_num(random_num));

    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Clock with a period of 20ns
    end

    initial begin
        reset = 1; #20;
        reset = 0; // Release reset to start LFSR
        #1000; // Run for a certain period to observe the pseudo-random sequence
        $finish;
    end
endmodule
