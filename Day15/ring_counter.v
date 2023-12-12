module ring_counter (
    input clk, reset,
    output reg [3:0] out
);

    // On reset, set the first bit high. Otherwise, rotate the bits.
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 4'b0001;
        else
            out <= {out[2:0], out[3]};
    end

endmodule
