module clock_divider (
    input clk_in,       // Input clock
    input reset,        // Asynchronous reset
    output reg clk_out  // Divided clock output
);

    reg [1:0] count; // 2-bit counter

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            count <= 2'b00;
            clk_out <= 1'b0;
        end else begin
            count <= count + 1'b1;
            if (count == 2'b11) begin
                clk_out <= ~clk_out; // Toggle the output clock
                count <= 2'b00;
            end
        end
    end

endmodule
