`timescale 1ns / 1ps

module testbench;

    reg clk, reset;
    wire red, yellow, green;

    // Instantiate the traffic light controller
    traffic_light_controller tlc (.clk(clk), .reset(reset), .red(red), .yellow(yellow), .green(green));

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Test sequence
    initial begin
        reset = 1; #20;
        reset = 0; 
        #100;
        $finish;
    end

    // Monitor the output
    initial begin
        $monitor("Time = %d, Red = %b, Yellow = %b, Green = %b", $time, red, yellow, green);
    end

endmodule
