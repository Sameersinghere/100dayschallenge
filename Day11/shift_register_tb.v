`timescale 1ns / 1ps

module testbench;

    // Inputs
    reg clk;
    reg reset;
    reg [3:0] din;

    // Outputs
    wire [3:0] dout;

    // Instantiate the Unit Under Test (UUT)
    shift_register uut (
        .clk(clk),
        .reset(reset),
        .din(din),
        .dout(dout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Toggle clock every 10 ns
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1; // Assert reset
        din = 4'b1010; // Initial data input
        #20;       // Wait for 20 ns
        reset = 0; // Deassert reset to start shifting
        
        // Apply data input and observe shift operation
        #20 din = 4'b1100;
        #20 din = 4'b0011;
        #20 din = 4'b0101;
        
        // Assert reset again to test synchronous reset behavior
        #20 reset = 1;
        #20 reset = 0;
        din = 4'b1111;

        // Finish simulation after a short delay
        #100 $finish;
    end

    // Monitor changes in outputs
    initial begin
        $monitor("Time = %d, Reset = %b, Data Input = %b, Data Output = %b", $time, reset, din, dout);
    end

endmodule
