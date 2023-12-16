module parity_bit_generator(
    input [7:0] data,
    output parity_bit
);
    assign parity_bit = ^data; // XOR all bits of data for even parity
endmodule
