`timescale 1ns / 1ps

module comparator_2bit_tb;

reg [1:0] A;
reg [1:0] B;
wire A_gt_B;
wire A_eq_B;
wire A_lt_B;

// Instantiate the Unit Under Test (UUT)
comparator_2bit uut (
    .A(A), 
    .B(B), 
    .A_gt_B(A_gt_B), 
    .A_eq_B(A_eq_B), 
    .A_lt_B(A_lt_B)
);

initial begin
    // Initialize Inputs
    A = 0;
    B = 0;

    // Wait 100 ns for global reset to finish
    #100;
      
    // Add stimulus here
    A = 2'b01; B = 2'b00; #10;
    A = 2'b10; B = 2'b10; #10;
    A = 2'b11; B = 2'b01; #10;
    A = 2'b00; B = 2'b10; #10;
    
    // Finish the simulation
    $finish;
end

initial begin
    $monitor("Time = %d ns, A = %b, B = %b, A_gt_B = %b, A_eq_B = %b, A_lt_B = %b", $time, A, B, A_gt_B, A_eq_B, A_lt_B);
end

endmodule
