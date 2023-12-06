`timescale 1ns / 1ps

module sr_latch_nand_tb;

// Inputs
reg S;
reg R;

// Outputs
wire Q;
wire Qbar;

// Instantiate the Unit Under Test (UUT)
sr_latch_nand uut (
    .S(S), 
    .R(R), 
    .Q(Q), 
    .Qbar(Qbar)
);

initial begin
    // Initialize Inputs
    S = 0;
    R = 0;

    // Wait for global reset
    #100;
    
    // Set
    S = 1;
    R = 0;
    #100;
    
    // Reset
    S = 0;
    R = 1;
    #100;
    
    // Invalid state (not recommended for actual circuits)
    S = 1;
    R = 1;
    #100;

    // Return to normal state
    S = 0;
    R = 0;
    #100;
    
    $finish;
end

initial begin
    $monitor("Time = %d, S = %b, R = %b, Q = %b, Qbar = %b", $time, S, R, Q, Qbar);
end

endmodule
