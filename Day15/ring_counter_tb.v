`timescale 1ns / 1ps

module ring_counter_tb;

    reg clk, reset;
    wire [3:0] out;

    // Instantiate the ring counter
    ring_counter rc (.clk(clk), .reset(reset), .out(out));

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Generate a clock with a period of 20ns
    end

    // Test sequence
    initial begin
        reset = 1; #15;
        reset = 0; 
        #200;
        reset = 1; #15;
        reset = 0; 
        #100;
        $finish;
    end

    // Monitor the output
    initial begin
        $monitor("Time = %d, Out = %b", $time, out);
    end

endmodule
