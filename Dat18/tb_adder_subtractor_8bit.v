`timescale 1ns / 1ps

module tb_adder_subtractor_8bit();
    reg [7:0] a, b;
    reg mode;
    wire [7:0] result;
    wire carry_out;

    adder_subtractor_8bit uut (.a(a), .b(b), .mode(mode), .result(result), .carry_out(carry_out));

    initial begin
        // Test addition
        a = 8'h55; // Test value
        b = 8'hAA; // Test value
        mode = 0;  // Addition mode
        #10;

        // Test subtraction
        a = 8'h55; // Test value
        b = 8'h30; // Test value
        mode = 1;  // Subtraction mode
        #10;

        $finish;
    end
endmodule
