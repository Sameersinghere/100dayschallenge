`timescale 1ns / 1ps

module testbench;

    // Inputs
    reg clk_in;
    reg reset;

    // Output
    wire clk_out;

    // Instantiate the Unit Under Test (UUT)
    clock_divider uut (
        .clk_in(clk_in), 
        .reset(reset), 
        .clk_out(clk_out)
    );

    // Clock generation
    initial begin
        clk_in = 0;
        forever #10 clk_in = ~clk_in; // 50MHz clock
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        reset = 1; // Assert reset
        #30;       // Wait for 30ns
        reset = 0; // Deassert reset

        // Wait for 200ns to observe the clock divider output
        #200;

        // End the simulation
        $finish;
    end

    // Monitor changes in outputs
    initial begin
        $monitor("Time = %d, clk_in = %b, clk_out = %b", $time, clk_in, clk_out);
    end

endmodule
