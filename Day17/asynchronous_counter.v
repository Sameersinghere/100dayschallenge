module asynchronous_counter(
    input clk,
    input reset,
    output reg [3:0] count
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 0;
        else
            count[0] <= ~count[0];
    end

    always @(posedge count[0] or posedge reset) begin
        if (reset)
            count[1] <= 0;
        else
            count[1] <= ~count[1];
    end

    // Continue this pattern for count[2] and count[3]
endmodule
