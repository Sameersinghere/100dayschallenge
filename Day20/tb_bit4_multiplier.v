`timescale 1ns / 1ps

module tb_bit4_multiplier();
    reg [3:0] a, b;
    wire [7:0] product;

    bit4_multiplier uut (.a(a), .b(b), .product(product));

    initial begin
        // Test Case 1
        a = 4'b0011; // 3 in decimal
        b = 4'b0101; // 5 in decimal
        #10; // Wait for 10 ns

        // Test Case 2
        a = 4'b0110; // 6 in decimal
        b = 4'b0011; // 3 in decimal
        #10; // Wait for 10 ns

        $finish;
    end
endmodule
