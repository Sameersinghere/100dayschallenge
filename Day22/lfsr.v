module lfsr(
    input clk,
    input reset,
    output reg [7:0] random_num
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            random_num <= 8'b00000001; // Non-zero initial value
        else
            random_num <= {random_num[6:0], random_num[7] ^ random_num[5]}; // Example feedback polynomial: x^8 + x^6 + 1
    end
endmodule
