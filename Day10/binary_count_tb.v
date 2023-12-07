`timescale 1ns / 1ps

module binary_count_tb;

    // Inputs
    reg clk;
    reg reset;

    // Outputs
    wire [3:0] out;

    // Instantiate the Unit Under Test (UUT)
    binary_counter uut (
        .clk(clk),
        .reset(reset),
        .out(out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 time units
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1; // Assert reset
        #10;       // Wait for 10 time units
        reset = 0; // Deassert reset to start the counter
        
        // Wait for 100 time units to observe counter output
        #100;
        
        // Assert reset again to test asynchronous reset behavior
        #10 reset = 1;
        #10 reset = 0;

        // Finish simulation after a short delay
        #30 $finish;
    end

    // Monitor changes in outputs
    initial begin
        $monitor("Time = %d, Reset = %b, Output = %b", $time, reset, out);
    end

endmodule
