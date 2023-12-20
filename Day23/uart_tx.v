module uart_tx (
    input clk,
    input reset,
    input [7:0] data_in,
    input data_valid,
    output reg tx,
    output reg tx_busy
);

    // Baud rate generation constants
    parameter integer CLOCK_FREQ = 50_000_000; // 50 MHz clock
    parameter integer BAUD_RATE = 115200;
    parameter integer BAUD_VALUE = CLOCK_FREQ / BAUD_RATE;

    reg [7:0] buffer;
    reg [3:0] bit_count;
    reg [15:0] baud_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            tx <= 1'b1; // Idle state high
            tx_busy <= 1'b0;
            baud_count <= 0;
            bit_count <= 0;
        end else begin
            if (data_valid && !tx_busy) begin
                buffer <= data_in;
                tx_busy <= 1'b1;
                bit_count <= 0;
            end

            if (tx_busy) begin
                if (baud_count == BAUD_VALUE - 1) begin
                    baud_count <= 0;
                    bit_count <= bit_count + 1;
                    if (bit_count == 0) tx <= 0; // Start bit
                    else if (bit_count > 0 && bit_count < 9) tx <= buffer[bit_count - 1];
                    else if (bit_count == 9) tx <= 1; // Stop bit
                    else tx_busy <= 0;
                end else begin
                    baud_count <= baud_count + 1;
                end
            end
        end
    end
endmodule
