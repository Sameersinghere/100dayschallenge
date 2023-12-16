`timescale 1ns / 1ps

module tb_parity_bit_generator();
    reg [7:0] data;
    wire parity_bit;

    parity_bit_generator uut (.data(data), .parity_bit(parity_bit));

    initial begin
        // Test Case 1: Even number of 1's
        data = 8'b10101010; // 4 ones, parity bit should be 0
        #10;

        // Test Case 2: Odd number of 1's
        data = 8'b10111010; // 5 ones, parity bit should be 1
        #10;

        $finish;
    end
endmodule
