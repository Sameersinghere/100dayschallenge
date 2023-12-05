`timescale 1ns / 1ps

module mux4to1_tb;

// Inputs
reg [3:0] in;
reg [1:0] sel;

// Output
wire out;

// Instantiate the Unit Under Test (UUT)
mux4to1 uut (
    .in(in), 
    .sel(sel), 
    .out(out)
);

initial begin
    // Initialize Inputs
    in = 4'b1010;  // Example input where in[0] = 0, in[1] = 1, in[2] = 0, in[3] = 1
    sel = 2'b00;  // Select input in[0]
    #10;           // Wait for 10ns

    sel = 2'b01;  // Select input in[1]
    #10;           // Wait for 10ns
    
    sel = 2'b10;  // Select input in[2]
    #10;           // Wait for 10ns

    sel = 2'b11;  // Select input in[3]
    #10;           // Wait for 10ns

    // Finish the simulation
    $finish;
end

initial begin
    $monitor("Time = %d, Selected Input = %b, Output = %b", $time, sel, out);
end

endmodule
