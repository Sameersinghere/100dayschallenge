module binary_counter (
    input clk,          // Clock input
    input reset,        // Asynchronous reset input
    output reg [3:0] out // 4-bit output
);

    // Counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 4'b0000; // Reset counter to 0
        end else begin
            out <= out + 1'b1; // Increment counter
        end
    end

endmodule
