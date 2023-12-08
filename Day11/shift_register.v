module shift_register (
    input clk,          // Clock input
    input reset,        // Synchronous reset input
    input [3:0] din,    // 4-bit data input
    output reg [3:0] dout // 4-bit data output
);

    // Shift register logic
    always @(posedge clk) begin
        if (reset) begin
            dout <= 4'b0000; // Clear register to 0 on reset
        end else begin
            dout <= {dout[2:0], din[3]}; // Shift left operation
        end
    end

endmodule
