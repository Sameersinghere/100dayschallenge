module adder_subtractor_8bit(
    input [7:0] a,
    input [7:0] b,
    input mode,  // 0 for addition, 1 for subtraction
    output reg [7:0] result,
    output reg carry_out
);
    always @(a, b, mode) begin
        if (mode == 1'b0) begin
            // Addition
            {carry_out, result} = a + b;
        end else begin
            // Subtraction
            {carry_out, result} = a - b;
        end
    end
endmodule
